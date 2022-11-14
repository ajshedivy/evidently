#!/bin/bash

if (($# == 0)); then
    echo "usage: ./start.sh --file [run_example.py]"
    exit 0
fi

POSITIONAL_ARGS=()
HELP_MSG=NO

while [[ $# -gt 0 ]]; do
  case $1 in
    -f|--file)
      CONFIG="$2"
      shift # past argument
      shift # past value
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done
set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

echo "File           = ${CONFIG}"
echo "activate evidently-grafana environment"
eval "$(conda shell.bash hook)"

conda activate evidently-grafana
if [ $? -ne 0 ]; then
   	echo "environment does not exist"
	echo "creating conda environment"
	conda env create -f environment.yml
	conda activate evidently-grafana
fi
echo "environment activated"

python ${CONFIG}
