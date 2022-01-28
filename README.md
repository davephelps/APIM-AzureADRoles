# AzureADRoles

Scripts to:
1) Create Azure App Registrations representing a service, with roles
2) Create Azure App Registration representing a client
3) Grant access for the client to roles on the service

To fetch a token, issue an HTTP POST in the following format (from https://docs.microsoft.com/en-us/azure/active-directory/develop/v2-oauth2-client-creds-grant-flow)

POST https://login.microsoftonline.com/your tenant/oauth2/v2.0/token           //Line breaks for clarity
Content-Type: application/x-www-form-urlencoded
client_id=client_id from the client app registration
&scope=your application id/.default the application id defined for the service app registration (this is the v2 endpoint, for v1 remove the ".default")
&client_secret=sampleCredentia1s for the client application
&grant_type=client_credentials

