import os
import re
from datetime import datetime
import shutil
from django.http import HttpResponseRedirect
from django.shortcuts import render
import subprocess

from .forms import InputForm, OutputForm


def get_info(request):
    # if this is a POST request we need to process the form data
    if request.method == "POST":
        # create a form instance and populate it with data from the request:
        form = InputForm(request.POST)
        # check whether it's valid:
        if form.is_valid():
            # process the data in form.cleaned_data as required
            # ...
            # redirect to a new URL:
            return HttpResponseRedirect("/thanks/")

    # if a GET (or any other method) we'll create a blank form
    else:
        form = InputForm()

    return render(request, "home.html", {"form": form})


def output(request):
    if request.method == "POST":
        rp = request.POST
        form = InputForm(rp)
        if form.is_valid():
            code = run_texplain(form.cleaned_data)
        if code == 0:
            outp = "Error running tExplain!\n"
            form = OutputForm({
                'narrative': rp['narrative'],
                'output': outp})
        else:
            form = OutputForm({
                'narrative': rp['narrative'],
                'output': code.decode("utf-8")})
        return render(request, 'output.html', {'form': form})


def run_texplain(raw_map):
    narrative = "Master/Narratives/narr" + \
        datetime.now().strftime("%d-%m-%Y-%H-%M-%S") + ".txt"
    # narrative = "narrative.txt"
    print(narrative)
    old = os.getcwd()
    os.chdir("tExplain-main")
    with open(narrative, "w") as f:
        f.writelines(raw_map["narrative"])
    f.close()

    deleteTempFiles("Master/Narratives/")
    deleteTempFiles("Master/Tuples/")
    deleteTempFiles("Master/LogicPrograms/")
    deleteTempFiles("Output/Text2ALM_Outputs/")

    command = "python runbAbI.py " + narrative
    # command = ""

    try:
        return subprocess.check_output(command, shell=True)
    except Exception as e:
        return 0
    finally:
        os.chdir(old)

def sorted_ls(path):
    mtime = lambda f: os.stat(os.path.join(path, f)).st_mtime
    return list(sorted(os.listdir(path), key=mtime))

def deleteTempFiles(path):
    valuable_files = ["process.py"]
    max_Files = 50
    del_list = sorted_ls(path)[0:(len(sorted_ls(path))-max_Files)]
    # print(del_list)
    full_path = [path+"{0}".format(x) for x in del_list]

    for fi in full_path:
        if os.path.isdir(fi):
            print("Will delete DIRECTORY:" + fi)
            shutil.rmtree(fi)
        else:
            if not fi.endswith(".py"):
                print("Will delete FILE:" + fi)
                os.remove(fi)