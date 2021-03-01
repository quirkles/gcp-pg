import { CloudFunctionsServiceClient } from '@google-cloud/functions';

// Creates a client
const client = new CloudFunctionsServiceClient();

const listFunctions = () => client.listFunctions({
  parent: 'projects/stunning-surge-306101/locations/-',
});

listFunctions()
  .then((fns) => { console.log(fns); })
  .catch((err) => { console.log(err.message); });
