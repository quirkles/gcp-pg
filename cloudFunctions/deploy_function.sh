functionName=false
while getopts f: flag
do
    case "${flag}" in
        f) functionName=${OPTARG};;
        *) echo "$flag not recognized, ignoring."
    esac
done

validFunctionName=false

declare -a dirs
i=1
for d in */
do
    dir=${d%/}
    dirs[i++]="$dir"
    if [[ "$functionName" == "$dir" ]]
    then
      validFunctionName=true
    fi
done

if [[ ! $validFunctionName ]]
then
    if [[ $functionName ]]
    then
      echo "$functionName is not a valid function name"
    fi
    echo "Please select a function form these options"
    select dir in "${dirs[@]}"; do echo "Selected ${dir}"; break; done
fi

buildDir=./$functionName/build

if test -d "$buildDir"; then
    echo "Cleaning up previous build dir at $buildDir."
    rm -rf "$buildDir"
fi

if test -f "$functionName/index.js"; then
    echo "Removing previous compiled file"
    rm "$functionName/index.js"
fi

echo "Compiling typescript"

cp tsconfig.cloudFunction.json "$functionName"

cp .gcloudignore "$functionName"

npx tsc -p ./"$functionName"/tsconfig.cloudFunction.json;

cp $functionName/package.json $buildDir

rm ./"$functionName"/tsconfig.cloudFunction.json


gcloud builds submit --config cloudbuild.deploy-function.json --substitutions=_FUNCTION_NAME="$functionName",_PROJECT_ID="stunning-surge-306101"

echo "Cleaning up build dir."
rm -rf "$buildDir"

echo "Cleaning up gcloudignore file."
rm "$functionName/.gcloudignore"
