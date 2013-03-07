#define MyAppName "Demoiselle 2 Infra"
#define MyAppVersion "1.0"
#define MyAppPublisher "Comunidade Demoiselle"
#define MyAppDesktopName "Demoiselle Eclipse 3.7 SR2"
#define MyAppURL "http://www.frameworkdemoiselle.gov.br"
#define MyAppExeName "\ide\eclipse-3.7-SR2\eclipse.exe"
#define MyAppFrameworkDemoiselle "Framework Demoiselle"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{616866B5-2C53-4BAB-9C8F-2C0B921EC563}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName=C:\Demoiselle
DisableDirPage=yes
DefaultGroupName={#MyAppName}
OutputDir=.
OutputBaseFilename=demoiselle-2-infra-win64-{#MyAppVersion}
Compression=lzma
SolidCompression=yes
WizardImageFile=fundo1.bmp
WizardSmallImageFile=fundo2.bmp
ArchitecturesAllowed=x64
ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: english; MessagesFile: compiler:Default.isl
Name: brazilianportuguese; MessagesFile: compiler:Languages\BrazilianPortuguese.isl

[Tasks]
Name: desktopicon; Description: {cm:CreateDesktopIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked
Name: quicklaunchicon; Description: {cm:CreateQuickLaunchIcon}; GroupDescription: {cm:AdditionalIcons}; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: C:\Demoiselle\ide\eclipse-3.7-SR2\*; Excludes: configuration\*.log; DestDir: {app}\ide\eclipse-3.7-SR2; Flags: ignoreversion recursesubdirs createallsubdirs
Source: C:\Demoiselle\tool\maven2\*; DestDir: {app}\tool\maven2\; Flags: ignoreversion recursesubdirs createallsubdirs
Source: C:\Demoiselle\tool\maven2-local-repo\*; DestDir: {app}\tool\maven2-local-repo\; Flags: ignoreversion recursesubdirs createallsubdirs
Source: C:\Demoiselle\server\tomcat-7.0\*; DestDir: {app}\server\tomcat-7.0; Flags: ignoreversion recursesubdirs createallsubdirs
Source: C:\Demoiselle\server\jboss-6.1\*; Excludes: server\default\data,server\default\log,server\default\tmp,server\default\work,bin\*.lck,bin\*.log,bin\*.script; DestDir: {app}\server\jboss-6.1; Flags: ignoreversion recursesubdirs createallsubdirs
Source: C:\Demoiselle\server\jboss-7.1\*; Excludes: server\default\data,server\default\log,server\default\tmp,server\default\work,bin\*.lck,bin\*.log,bin\*.script; DestDir: {app}\server\jboss-7.1; Flags: ignoreversion recursesubdirs createallsubdirs
Source: C:\Demoiselle\workspace\*; Excludes: workspace\.metadata\.log,workspace\.metadata\.lock,workspace\.metadata\.bak_*.log,workspace\.metadata\.plugins\org.eclipse.core.resources\.history\*,workspace\.metadata\.plugins\org.jboss.tools.jst.web.kb\projects\*,workspace\.metadata.plugins\org.maven.ide.eclipse\dialog_settings.xml,workspace\.metadata\.plugins\org.maven.ide.eclipse\nexus\,workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\logs\*,workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\temp\*,workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\webapps\*; DestDir: {app}\workspace; Flags: onlyifdoesntexist sharedfile uninsneveruninstall recursesubdirs createallsubdirs

[Icons]
Name: {group}\{#MyAppDesktopName}; Filename: {app}\{#MyAppExeName}
Name: {group}\{cm:ProgramOnTheWeb,{#MyAppFrameworkDemoiselle}}; Filename: {#MyAppURL}
Name: {group}\{cm:UninstallProgram,{#MyAppName}}; Filename: {uninstallexe}
Name: {commondesktop}\{#MyAppDesktopName}; Filename: {app}\{#MyAppExeName}; Tasks: desktopicon
Name: {userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}; Filename: {app}\{#MyAppExeName}; Tasks: quicklaunchicon

[Run]
Filename: {app}\{#MyAppExeName}; Description: {cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}; Flags: nowait postinstall skipifsilent

[Registry]
Root: HKLM; Subkey: SYSTEM\CurrentControlSet\Control\Session Manager\Environment; ValueType: string; ValueName: CATALINA_HOME; ValueData: {app}\server\tomcat-7.0
Root: HKLM; Subkey: SYSTEM\CurrentControlSet\Control\Session Manager\Environment; ValueType: string; ValueName: JBOSS_HOME; ValueData: {app}\server\jboss-7.1
Root: HKLM; Subkey: SYSTEM\CurrentControlSet\Control\Session Manager\Environment; ValueType: string; ValueName: M2_HOME; ValueData: {app}\tool\maven2
Root: HKLM; Subkey: System\CurrentControlSet\Control\Session Manager\Environment; ValueType: string; ValueName: JAVA_HOME; ValueData: {code:GetJAVAHome|Default}; Flags: uninsdeletekeyifempty createvalueifdoesntexist

[Code]
var
javaPath: String;

function InitializeSetup(): Boolean;
var
 ErrorCode: Integer;
 JavaInstalled : Boolean;
 Result1 : Boolean;
 Versions: TArrayOfString;
 I: Integer;
begin
 if RegGetSubkeyNames(HKLM, 'SOFTWARE\JavaSoft\Java Development Kit', Versions) then
 begin
  for I := 0 to GetArrayLength(Versions)-1 do
   if JavaInstalled = true then
   begin
    //do nothing
   end else
   begin
    if ( Versions[I][2]='.' ) and ( ( StrToInt(Versions[I][1]) > 1 ) or ( ( StrToInt(Versions[I][1]) = 1 ) and ( StrToInt(Versions[I][3]) >= 6 ) ) ) then
    begin
     JavaInstalled := true;

     RegQueryStringValue(HKLM, 'SOFTWARE\JavaSoft\Java Development Kit\' + Versions[I], 'JavaHome', javaPath);
    end else
    begin
     JavaInstalled := false;
    end;
   end;
 end else
 begin
  JavaInstalled := false;
 end;

 if JavaInstalled then
 begin
  Result := true;
 end else
    begin
  Result1 := MsgBox('This tool requires Java Development Kit more than 1.6 to run. Please download and install the JDK and run this setup again. Do you want to download it now?',
   mbConfirmation, MB_YESNO) = idYes;
  if Result1 = false then
  begin
   Result:=false;
  end else
  begin
   Result:=false;
   ShellExec('open',
    'http://www.oracle.com/technetwork/java/javase/downloads/',
    '','',SW_SHOWNORMAL,ewNoWait,ErrorCode);
  end;
    end;
end;

function GetJAVAHome(S: String) : String;
begin
  Result := javaPath;
end;

end.
