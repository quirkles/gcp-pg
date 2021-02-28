gatewayName=false
while getopts g: flag
do
    case "${flag}" in
        g) gatewayName=${OPTARG};;
        *) echo "$flag not recognized, ignoring."
    esac
done


validGatewayName=false

declare -a dirs
i=1
for d in */
do
    dir=${d%/}
    dirs[i++]="$dir"
    if [[ "$gatewayName" == "$dir" ]]
    then
      validGatewayName=true
    fi
done

if [[ ! $validgatewayName ]]
then
    if [[ $gatewayName ]]
    then
      echo "$gatewayName is not a valid gateway name"
    fi
    echo "Please select a function form these options"
    select dir in "${dirs[@]}"; do echo "Selected ${dir}"; break; done
fi

if [[  "$(gcloud api-gateway apis list | grep -ce $gatewayName)" == 0 ]]
then
  echo "creating gateway ${gatewayName}"
  gcloud builds submit \
    --config cloudbuild.create-gateway.json \
    --substitutions=_GATEWAY_ID="my-test-gateway",_PROJECT_ID="stunning-surge-306101"
else
  echo "gateway exists already"
fi

