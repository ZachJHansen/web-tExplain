import os
import re
from datetime import datetime
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
    narrative = "Master/Narratives/" + \
        datetime.now().strftime("%d-%m-%Y-%H-%M-%S") + ".txt"
    # narrative = "narrative.txt"
    print(narrative)
    old = os.getcwd()
    os.chdir("tExplain-main")
    with open(narrative, "w") as f:
        f.writelines(raw_map["narrative"])
    f.close()

    # list_of_files = os.listdir('Master/Narratives/')
    # full_path = ["Master/Narratives/{0}".format(x) for x in list_of_files]

    # if len(list_of_files) >= 40:
    #     oldest_file = min(full_path, key=os.path.getctime)
    #     os.remove(oldest_file)

    # os.chdir(old)

    command = "python runbAbI.py " + narrative
    print(os.getcwd())
    # output = os.system(command)
    try:
        return subprocess.check_output(command, shell=True)
    except Exception as e:
        return 0
    finally:
        os.chdir(old)
