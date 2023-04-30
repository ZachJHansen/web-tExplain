#!/bin/bash
SERVER_LOG_1_FILE="StanfordCoreNLPServer.log"
SERVER_LOG_2_FILE="run_http_server.log"
SEARCH_PATTERN_1="[main] INFO CoreNLP - StanfordCoreNLPServer listening at"
SEARCH_PATTERN_2="done."

DIR=$(pwd)
SERVER_LOG_1_FILE=$DIR/$SERVER_LOG_1_FILE
SERVER_LOG_2_FILE=$DIR/$SERVER_LOG_2_FILE

cd $(ls -d resources/stanford-corenlp-*)
echo "starting StanfordCoreNLPServer..."
stdbuf -oL java -mx4g -cp "*" edu.stanford.nlp.pipeline.StanfordCoreNLPServer -port 9001 -timeout 45000 > ${SERVER_LOG_1_FILE} 2>&1 &

tail -f ${SERVER_LOG_1_FILE} &
tail_pidA=$!

stdbuf -oL tail -f  ${SERVER_LOG_1_FILE} | stdbuf -oL grep -qF "${SEARCH_PATTERN_1}" | stdbuf -oL head -n1

if [ $? == 0 ]; then
    echo "StanfordCoreNLPServer started"
    echo
fi

kill -9 $tail_pidA &

cd $DIR
cd $(ls -d resources/srl-*)/scripts
echo "starting run_http_server..."
sh run_http_server.sh 8071 ~/Text2ALM/resources/models/eng  > ${SERVER_LOG_2_FILE} 2>&1 &

# tail -f ${SERVER_LOG_2_FILE} &
# tail_pidB=$!

stdbuf -oL tail -f  ${SERVER_LOG_2_FILE} | stdbuf -oL grep -qF "${SEARCH_PATTERN_2}" | stdbuf -oL head -n1

# kill -9 $tail_pidB  2>/dev/null
