# Check if the resource group exists
resource_group=$(az group show --name udacity-rg --query "name" -o tsv 2>/dev/null)
if [ -z "$resource_group" ]; then
  resource_group=$(az group create --name udacity-rg --location canadacentral --query "name" -o tsv)
fi

# Check if the app service plan exists
appservice_plan=$(az appservice plan show --name idelfonsog2_asp_4308 --resource-group $resource_group --query "name" -o tsv 2>/dev/null)
if [ -z "$appservice_plan" ]; then
  appservice_plan=$(az appservice plan create --name idelfonsog2_asp_4308 --resource-group $resource_group --sku B1 --is-linux --query "name" -o tsv)
fi

# Check if the web app exists
webapp_url=$(az webapp show --name final-ml-flask --resource-group $resource_group --query "defaultHostName" -o tsv 2>/dev/null)
if [ -z "$webapp_url" ]; then
  webapp_url=$(az webapp up -n final-ml-flask --resource-group $resource_group --plan $appservice_plan --query "defaultHostName" -o tsv)
fi

echo "Your app is deployed at: https://$webapp_url"

