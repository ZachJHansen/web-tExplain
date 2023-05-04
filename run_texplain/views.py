import os
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
        if code != 0:
            outp = "Error running Anthem-P2P!\n"
        form = OutputForm({
            'narrative': rp['narrative'],
            'output': code.decode("utf-8")})
        return render(request, 'output.html', {'form': form})


def run_texplain(raw_map):
    with open("narrative.txt", "w") as f:
        f.writelines(raw_map["narrative"])
    f.close()
    command = "python runbAbI.py ../narrative.txt"
    old = os.getcwd()
    os.chdir("tExplain-main")
    # print(os.getcwd())
    # output = os.system(command)
    output = subprocess.check_output(command, shell=True)
    os.chdir(old)
    return output
