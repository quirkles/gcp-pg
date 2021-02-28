source ~/.zshrc;
cd ../
rm -rf build/cloudFunctions
nvm use;
npx tsc -p ./tsconfig.cloudFunctions.json;
