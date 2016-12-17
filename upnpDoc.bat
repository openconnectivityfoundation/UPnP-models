rem ==================================================
rem batch file that creates the RAML resource sections
rem ==================================================

rem set Template="u:\Standards\Groups\OIC\UPnP\OCF_UPnP_Resource_v.0.1.docx"

set UPnPTemplateDoc="OCF_UPnP_Resource_v.0.1.docx"
set TemplateDir="C:\Users\rsbell\Downloads\OCF-Documents\"
set UPnPModelsDir="H:\work\iotivity-master\oneiota\UPnP-models"

rem choice of application: python or exectuable
set cmd=C:\Python27\python.exe  raml2doc-met.py
rem set cmd=raml2doc.exe

rem make sure that correct template is used
copy %TemplateDir%\%UPnPTemplateDoc%  .\%UPnPTemplateDoc%

rem UPnP Resources 
copy %UPnPModels%\upnpDevice.raml  .
%cmd% -raml upnpDevice.raml -resource /upnpDeviceResURI -docx %UPnPTemplateDoc%

copy %UPnPModels%\icon.raml  .
%cmd% -raml icon.raml -resource /IconResURI -docx upnpDevice.raml.docx

copy %UPnPModels%\upnpService.raml  .
%cmd% -raml upnpService.raml -resource /upnpServiceResURI -docx icon.raml.docx

copy %UPnPModels%\upnpStateVariable.raml  .
%cmd% -raml upnpStateVariable.raml -resource /upnpStateVariableResURI -docx upnpService.raml.docx

copy %UPnPModels%\upnpAction.raml  .
%cmd% -raml upnpAction.raml -resource /upnpActionResURI -docx upnpStateVariable.raml.docx

copy %UPnPModels%\generic.raml  .
%cmd% -raml generic.raml -resource /GenericResURI -docx upnpAction.raml.docx
copy  generic.raml.docx %TemplateDir%\%UPnPTemplateDoc%_generated.docx

rem %cmd% -raml upnpList.raml -resource /upnpDeviceListResURI -docx upnpStateVariable.raml.docx

del -f *.raml *.docx
