unit UIAutoWrapper;

interface

type
  TSimpleFunc = procedure; stdcall;
  TLaunchFunc = procedure (const val1, val2: String);
  TStringFunc = procedure (const value: String);

  TUIAutoWrapper = class
  private
    dllHandle : THandle;

    simpleFunc: TSimpleFunc;
    launchOrAttachFunc: TLaunchFunc;
    killFunc: TSimpleFunc;
    initializeFunc: TSimpleFunc;
    finalizeFunc: TSimpleFunc;
    waitWhileBusyFunc: TSimpleFunc;
    getDesktopWindowFunc: TStringFunc;
    maximizeFunc: TSimpleFunc;

  public
    constructor Create;
    destructor Destroy;

    procedure Launch(const val1, val2: String);
    procedure Kill;

    procedure Initialize;
    procedure Finalize;

    procedure WaitWhileBusy;

    procedure GetDesktopWindow(const name: String);

    procedure Maximize;
  end;

implementation

uses
  dialogs,
  windows;

{ TUIAutoWrapper }

constructor TUIAutoWrapper.Create;
begin
  WriteLn('Loading DLL');
  dllHandle := LoadLibrary('C:\Users\humphreysm.JHCLLP\Documents\GitHub\DelphiUIAutomation\library\Win32\Debug\UIAutomation.dll') ;
  WriteLn('Loaded DLL');
  if dllHandle <> 0 then
  begin
    // Loaded the DLL successfully

    @simpleFunc := GetProcAddress(dllHandle, 'DllMessage') ;
    if Assigned (simpleFunc) then
      // call the function
      simpleFunc()
    else
      WriteLn('"DllMessage" function not found') ;

    @launchOrAttachFunc := getProcAddress(dllHandle, 'LaunchOrAttach');
    if not Assigned (launchOrAttachFunc) then
      WriteLn('"LaunchOrAttach" function not found') ;

    @killFunc := getProcAddress(dllHandle, 'Kill');
    if not Assigned (killFunc) then
      WriteLn('"Kill" function not found') ;

    @initializeFunc := getProcAddress(dllHandle, 'Initialize');
    if not Assigned (initializeFunc) then
      WriteLn('"Initialise" function not found') ;

    @finalizeFunc := getProcAddress(dllHandle, 'Finalize');
    if not Assigned (finalizeFunc) then
      WriteLn('"Finalize" function not found') ;

    @waitWhileBusyFunc := getProcAddress(dllHandle, 'WaitWhileBusy');
    if not Assigned (waitWhileBusyFunc) then
      WriteLn('"WaitWhileBusy" function not found');

    @getDesktopWindowFunc := getProcAddress(dllHandle, 'GetDesktopWindow');
    if not Assigned (getDesktopWindowFunc) then
      WriteLn('"GetDesktopWindow" function not found');

    @maximizeFunc := getProcAddress(dllHandle, 'Maximize');
    if not Assigned (maximizeFunc) then
      WriteLn('"Maximize" function not found');
  end
  else
    WriteLn('Dll not found') ;
end;

destructor TUIAutoWrapper.Destroy;
begin
  if (dllHandle <> -1) then
    FreeLibrary(dllHandle) ;
end;

procedure TUIAutoWrapper.Finalize;
begin
  self.FinalizeFunc;
end;

procedure TUIAutoWrapper.Initialize;
begin
  self.InitializeFunc;
end;

procedure TUIAutoWrapper.WaitWhileBusy;
begin
  self.waitWhileBusyFunc;
end;

procedure TUIAutoWrapper.GetDesktopWindow(const name: String);
begin
  self.getDesktopWindowFunc(name);
end;

procedure TUIAutoWrapper.Kill;
begin
  self.KillFunc;
end;

procedure TUIautoWrapper.maximize;
begin
  self.maximizeFunc;
end;

procedure TUIAutoWrapper.Launch(const val1, val2: String);
begin
  self.launchOrAttachFunc(val1, val2);
end;

end.
