SCRIPT_PATH=$(dirname $(realpath $0))
pip install -r requirements.txt
python -c "import nltk; nltk.download('punkt'); nltk.download('verbnet3')"

TMP_PATH=$(mktemp -d -t tExplain-XXXXXXXXXX)
mkdir -p ${TMP_PATH}
cd "${TMP_PATH}"
pwd
wget -i "${SCRIPT_PATH}/dependencies.txt"
ls 
tar -xf srl-4.21.tgz --directory="${SCRIPT_PATH}/resources"
mkdir -p "${SCRIPT_PATH}/resources/models/eng/"
mv *.model "${SCRIPT_PATH}/resources/models/eng/"
mv "${SCRIPT_PATH}/resources/models/eng/CoNLL2009-ST-English-ALL.anna-3.3.srl-4.1.srl.model" "${SCRIPT_PATH}/resources/models/eng/CoNLL2009-ST-English-ALL.anna-3.3.srl.model"
unzip stanford-corenlp-full-2018-10-05.zip -d "${SCRIPT_PATH}/resources/"
rm -rf "${TMP_PATH}"
