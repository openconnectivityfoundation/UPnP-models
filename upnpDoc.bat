rem ==================================================
rem batch file that creates the RAML resource sections
rem ==================================================

rem set Template="u:\Standards\Groups\OIC\UPnP\OCF_UPnP_Resource_v.0.1.docx"

set UPnPTemplateDoc="OCF_UPnP_Resource_v.0.3.docx"
rem set UPnPTemplateDoc="ResourceTemplate.docx"
set TemplateDir="C:\Users\rsbell\Downloads\OCF-Documents"
set UPnPModelsDir="C:\Users\rsbell\Documents\Git\oneiota\UPnPModels"

rem choice of application: python or exectuable
set cmd=C:\Python27\python.exe  raml2doc-met.py
rem set cmd=raml2doc.exe

rem make sure that correct template is used
copy %TemplateDir%\%UPnPTemplateDoc%  .\%UPnPTemplateDoc%
pause

rem Copy all raml and json files
copy %UPnPModelsDir%\upnpDevice.raml  .
copy %UPnPModelsDir%\oic.r.upnp.device.json  .
copy %UPnPModelsDir%\upnpService.raml  .
copy %UPnPModelsDir%\oic.r.upnp.service.json  .
copy %UPnPModelsDir%\upnpAction.raml  .
copy %UPnPModelsDir%\oic.r.upnp.action.json  .
copy %UPnPModelsDir%\upnpStateVariable.raml  .
copy %UPnPModelsDir%\oic.r.upnp.stateVariable.json  .
copy %UPnPModelsDir%\upnpGeneric.raml  .
copy %UPnPModelsDir%\oic.r.upnp.generic.json  .

rem UPnP Resources 
%cmd% -raml upnpDevice.raml -resource /upnpDeviceResURI -docx %UPnPTemplateDoc%
pause

%cmd% -raml upnpService.raml -resource /upnpServiceResURI -docx upnpDevice.raml.docx

%cmd% -raml upnpAction.raml -resource /upnpActionResURI -docx upnpService.raml.docx

%cmd% -raml upnpStateVariable.raml -resource /upnpStateVariableResURI -docx upnpAction.raml.docx

%cmd% -raml upnpGeneric.raml -resource /upnpGenericResURI -docx upnpStateVariable.raml.docx

rem copy %UPnPModelsDir%\icon.raml  .
rem %cmd% -raml icon.raml -resource /IconResURI -docx upnpGeneric.raml.docx

copy  upnpGeneric.raml.docx %TemplateDir%\%UPnPTemplateDoc%_generated.docx
pause

rem Delete all raml and json files
rem del -f *.json *.raml *.docx
del -f upnpDevice.raml oic.r.upnp.device.json upnpDevice.raml.docx
del -f upnpService.raml oic.r.upnp.service.json upnpService.raml.docx
del -f upnpAction.raml oic.r.upnp.action.json upnpAction.raml.docx
del -f upnpStateVariable.raml oic.r.upnp.stateVariable.json upnpStateVariable.raml.docx
del -f upnpGeneric.raml oic.r.upnp.generic.json upnpGeneric.raml.docx
del -f %UPnPTemplateDoc%
