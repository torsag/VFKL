# VFKL
"Veileder For Kvalitet i Læremidler"
Veileder For Kvalitet i Læremidler er en tjenste laget av UDIR basert på altinn.studio/altinn 3.0 [referansesystem](https://github.com/Altinn/AltinnApp/). Selve tjenesten kan du finne:https://www.udir.no/kvalitet-og-kompetanse/laremidler/kvalitetskriterier-for-laremidler/

Dette er Udir sin tjeneste for vurdering av kvalitet i læremidler. Her kan du som er skoleleder eller skoleeier invitere lærere til å gjøre en vurdering. Du blir bedt om å velge hvilket læremiddel som skal vurderes, hvilken læreplan det skal vurderes for og hvem du ønsker å invitere til å gjøre vurderingen. Etter at de inviterte lærerne har gjennomført vurdering, får du se resultatene i en samlevisning som kan brukes for drøfting og valg av læremiddel.

En hjelpeside for veilederen kan finnes her: 
https://www.udir.no/kvalitet-og-kompetanse/laremidler/kvalitetskriterier-for-laremidler/veiledere-for-kvalitet-i-laremidler/#a163161



## VFKL Core System (Kjernesystem)
VFKL core system is built to receive data from altinn3.0. We will consume the events produced by Altinn 3.0 for the application to fetch the data. To generate events for our app, we must first activate the event generation.How to activate generation of events in our application can be found [here](https://docs.altinn.studio/app/development/configuration/events/#activate-generation-of-events-in-your-application)

Core system will react to events pushed by altinn 3.0 and fetch data from altinn platformen. 

## Getting Started
Following instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## Clone the VFKL repository

Git clone https://github.com/Utdanningsdirektoratet/VFKL.git
	
## Prerequisites

1. .Net 6.0
2. For local development : Postgres on docker (It is also possible to install postgres directly)
	1. Install docker desktop from here https://docs.docker.com/desktop/windows/install/
	2. Run <<docker run -d -p 5432:5432 --name vfkl POSTGRES_PASSWORD=Test1234 vfkladmin>> to get the postgres database for vfkl up and running in the local development environment
3. Azure function core tools v4
	-	Install azure function core tools from here https://docs.microsoft.com/en-us/azure/azure-functions/functions-run-local?tabs=v4%2Cwindows%2Ccsharp%2Cportal%2Cbash
4. pgAdmin - Tool to manage the postgres database
	- Install pgAdmin from here https://www.pgadmin.org/download/
5. Microsoft recommends that we use Azurite for local Azure storage development. Azurite is a storage emulator. Azurite is automatically avaialable with Visualstudio 2022. If not, Azurite can be downloaded from
	
	https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azurite?tabs=visual-studio 
6. Azure Storage Explorer - This is used to view the local blob container, queue. It can also be used to manage the resources in azure.
	- It can be installed from here https://azure.microsoft.com/en-us/features/storage-explorer/#overview
7. Postman - This is used to test the api
	- You can either use postman web or use postman desktop
8. A code editor - Visual studio/Visual studio code

## Connect to the database using pgadmin

1. Open pgAdmin
2. Click on create-->server. You will see the following screen
	
	![pgAdmin, connect to server](/images/createserver.png)

3. Give a name f.ex vfkl-local
4. Click on connection and enter the following
![pgAdmin, connect to server](/images/createserver-connection.png)
	- Hostname/address : localhost
	- Port : 5432 (it is usually prefilled)
	- Maintenance database:postgres
	- Username : vfkladmin
5. Click save
6. Now you can see that your local server is listed under Servers
7. Click on vfkl-local--->Databases
8. Now you can see the system database postgres.

## Setup database

1. To setup the database for the first time, create a database by running the following sql script
	
		CREATE DATABASE Vfkl;
	
	The sql script can be run by opening the query tool window. To open the query tool window, right click on the postgres database and select query tool.
2. Run the cleandbdeploy.sql script that is found in deployment folder. This script will create the required schemas, tables and stored procedures

## Setup Local Storage
Local storage can also be managed using Azure storage explorer tool. 
- Open the Azure storage explorer. You will see an explorer in the left. Expand "Local & Attached", then Emulator
![azure storage explorer, Storage Emulator](/images/storageexplorer.png)
- Now you can see Blob containers, queues, tables if your emulator is running
![azure storage explorer, Storage Emulator](/images/storageexplorer-blobcontainers.png)
- Right click on the blob container and create a blob container "inbound"

## Setup the local settings

We need to setup a local settings file that will contain all the environment variable, settings needed to run the application locally. Add a new file called lcoal.settings.json

	{
	"IsEncrypted": false,
	"Values": {
		"ASPNETCORE_ENVIRONMENT": "Development",
		"FUNCTIONS_WORKER_RUNTIME": "dotnet-isolated",
		"QueueStorageSettings:ConnectionString": "UseDevelopmentStorage=true",
	    "VFKLCoreSettings:AccountKey":"Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==",
		"VFKLCoreSettings:AccountName": "devstoreaccount1",
		"VFKLCoreSettings:BlobEndpoint": "http://127.0.0.1:10000/devstoreaccount1",
		"VFKLCoreSettings:MaskinportenBaseAddress": "",
		"VFKLCoreSettings:MaskinportenAudience": "",
		"VFKLCoreSettings:AltinnMaskinportenApiEndpoint": "",
		"VFKLCoreSettings:MaskinPortenClientId": "",
		"VFKLCoreSettings:PlatformBaseUrl": "",
		"VFKLCoreSettings:AppsBaseUrl": "",
		"KeyVault:KeyVaultURI": "",
		"KeyVault:MaskinportenKey": "",
		"VFKLCoreSettings:DatabaseConnectionString": "Server=localhost;Database=vfkldb;Port=5432;User Id=postgres;Password=Test1234;",
		"AzureWebJobsSecretStorageType": "Files"
		}
	}

	The Blobendpoint, accountname, accountkey are configured with local storage emulator connections. By default, they are configured with the above values.

## Run the application locally

The application can be run locally either 
-	by pressing F5 from visual studio or 
-	Navigate to src/vfklcore and then Run <<func start>> 

### Test the application locally

The main trigger for the function is a http trigger and can be triggered by sending an api request to the EventsReceiver funtion.
1. Trigger the EventsReceiver function
	- Add the following in the request body
		
			{
				"source":  "https://udir.apps.tt02.altinn.no/udir/vfkl/instances/52043226/04e49a21-b2d5-4233-a6dc-9710b7678d3f",
				"subject": "party/52043226",
				"type": "app.instance.process.completed",
				"time":  "2022-05-03T09:06:50.3736712Z",
				"id": "91f2388f-bd8c-4647-8684-fd9f68af5b14"
			}

	Replace the <<52043226/04e49a21-b2d5-4233-a6dc-9710b7678d3f>> with your partyid/instanceid for testing
	- Run http://localhost:7071/api/EventsReceiver as a POST request
	- This will trigger the EventsReceiver function. The Events receiver will queue the event to the EvetsProcessor. 
	- The EventsProcessor will process the event in the queue and save the formdata, attachment data and instance data in the blob storage and in the database
2. Api to get the invitation information is also hosted as a function. Api request to get the invitation information can be triggered by 
	
		http://localhost:7071/api/assessment/lOQeEJST4kKrRQsolWqBew

	This will return the group invitation information. 

### Verify the data locally
Once the function is run, the received data can be verified by checking the local blob containers and the database.

#### Verify data in Blob
- Open the Azure storage explorer. You will see an explorer in the left. Expand "Local & Attached", then Emulator
![azure storage explorer, Storage Emulator](/images/storageexplorer.png)
- Now you can see Blob containers, queues, tables if your emulator is running
![azure storage explorer, Storage Emulator](/images/storageexplorer-blobcontainers.png)
- Click on Blob containers. A list of blob containers can be seen. When you click on inbound container, you can see folders on the right pane. Each folder represents an app in the Altinn3
![azure storage explorer, Storage Emulator](/images/storageexplorer-inbound.png)
- Click on one of the app to explore the data.
![azure storage explorer, Storage Emulator](/images/storageexplorer-inbound-content.png)
- You will see folders with guid as folder name. Each folder represent an instance that was sent in by user
![azure storage explorer, Storage Emulator](/images/storageexplorer-vfklcontent.png)

#### Verify data in Postgres
You can use pgadmin tool to connect to the local database and query the data to verify.