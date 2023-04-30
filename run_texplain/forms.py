from django import forms


class InputForm(forms.Form):
    time_limit = forms.CharField(max_length=100, required=False)
    narrative = forms.CharField(
        widget=forms.Textarea(attrs={"class": "form-control"}),
        initial='''1 Mary moved to the bathroom.
2 Sandra journeyed to the bedroom.
3 Mary got the football there.
4 John went to the kitchen.
5 Mary went back to the kitchen.
6 Mary went back to the garden.
7 Where is the football?
8 Sandra went back to the office.
9 John moved to the office.
10 Sandra journeyed to the hallway.
11 Daniel went back to the kitchen.
12 Mary dropped the football.
13 John got the milk there.
14 Where is the football?
15 Mary took the football there.
16 Sandra picked up the apple there.
17 Mary travelled to the hallway.
18 John journeyed to the kitchen.
19 Where is the football?
20 John moved to the hallway.
21 Sandra left the apple.
22 Where is the apple?
23 Mary got the apple there.
24 John travelled to the garden.
25 John went back to the hallway.
26 John went back to the bedroom.
27 Mary journeyed to the bedroom.
28 John journeyed to the kitchen.
29 John left the milk.
30 Mary left the apple.
31 Where is the milk?''')


class OutputForm(forms.Form):
    time_limit = forms.CharField(max_length=100, required=False)
    output = forms.CharField(widget=forms.Textarea(
        attrs={"id": "output", "readonly": "readonly"}))
    narrative = forms.CharField(
        widget=forms.Textarea(attrs={"class": "form-control"}),
        initial='''1 Mary moved to the bathroom.
2 Sandra journeyed to the bedroom.
3 Mary got the football there.
4 John went to the kitchen.
5 Mary went back to the kitchen.
6 Mary went back to the garden.
7 Where is the football? 	garden	3 6
8 Sandra went back to the office.
9 John moved to the office.
10 Sandra journeyed to the hallway.
11 Daniel went back to the kitchen.
12 Mary dropped the football.
13 John got the milk there.
14 Where is the football? 	garden	12 6
15 Mary took the football there.
16 Sandra picked up the apple there.
17 Mary travelled to the hallway.
18 John journeyed to the kitchen.
19 Where is the football? 	hallway	15 17
20 John moved to the hallway.
21 Sandra left the apple.
22 Where is the apple? 	hallway	21 10
23 Mary got the apple there.
24 John travelled to the garden.
25 John went back to the hallway.
26 John went back to the bedroom.
27 Mary journeyed to the bedroom.
28 John journeyed to the kitchen.
29 John left the milk.
30 Mary left the apple.
31 Where is the milk? 	kitchen	29 28''')
