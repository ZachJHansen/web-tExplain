# How to run tExplain
Clone this repository:
```
git clone https://github.com/jorgefandinno/tExplain.git
```

# System setup
Go to this repository's [system setup wiki](https://github.com/jorgefandinno/tExplain/wiki/System-Setup) to see how to prepare the system.

## Starting up Stanford CoreNLP
Run the command:
```
cd resources/srl-20131216/scripts/
sh run_http_server.sh 8071 '../../models/eng/'
```

## Starting up LTH
1. Open a new terminal.
2. Run the command:
```
cd resources/stanford-corenlp-full-2018-10-05/
java -mx4g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer -port 9001 -timeout 45000
```
## Config file
You are able to configure the **direct** file paths of `LogicProgram_directory`, `Tuples_directory`, `Queries_directory`, and `Xclingo_directory` if you wish.


## bAbI Narrative
To input a bAbI narrative, run:
```
python runbAbI.py Tuples/countingA.txt
```
Where the first argument `Tuples/countingA.txt` is the text file containing ONE bAbI narrative.

`runbAbI.py` will :
* create queries from the scripts located in the `Queries_directory`
* create narratives in the `Tuples_directory` location
* create logic programs in the `LogicProgram_directory` location
* show xclingo output for each narrative, logic program, and query in the `Xclingo_directory` location