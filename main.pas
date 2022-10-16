unit main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Memo1: TMemo;
    Splitter1: TSplitter;
    Memo2: TMemo;
    Edit1: TEdit;
    Label1: TLabel;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  DKeystone;

{$Message 'DEFAULT MODE = KS_ARCH_ARM64 + KS_MODE_LITTLE_ENDIAN'}

function sym_resolver(const symbol: PUTF8Char; value: PUInt64): Boolean; cdecl;
begin
  Result := False;
  if lstrcmpiA(symbol, 'sub_123458') = 0 then
  begin
      value^ := $123458;
      Result := True;
  end;
end;

function sym_resolver2(const symbol: PUTF8Char; value: PUInt64): Boolean; cdecl;
begin
  Result := False;
  if lstrcmpiA(symbol, 'loc_654321') = 0 then
  begin
    MessageBox(0, 'don''t know', 'loc_654321?', MB_OK);
  end;
end;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Address: NativeUInt;
begin
  Address := StrToInt('$' + Trim(Edit1.Text));
  with TKeystone.Create do
  begin
    Caption := Version;
    try
      SetSymResolverCb(@sym_resolver);
      if Assemble(Memo1.Text, Address) then
      begin
        Memo2.Text := EncodeStr(True);
        {$IFDEF _OR}
        Memo2.Text := Data.ToHex(True);
        {$ENDIF}
      end
      else
        Memo2.Text := ErrorStr;
    finally
      Free;
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i: Integer;
  Address: NativeUInt;
begin
  Address := StrToInt('$' + Trim(Edit1.Text));
  with TKeystone.Create do
  begin
    Memo2.Clear;
    try
      SetSymResolverCb(@sym_resolver2);
      for i := 0 to Memo1.Lines.Count - 1 do
      begin
        if Assemble(Memo1.Lines[i], Address) then
          Memo2.Lines.Add(Format('%.8x | %s', [Address, EncodeStr(False)]))
        else
          Memo2.Lines.Add(Format('%.8x | %s', [Address, ErrorStr]));
        Inc(Address, EncodingSize);
      end;
    finally
      Free;
    end;
  end;
end;

{$REGION 'SYMBOL RESOLVER TEST'}
procedure TForm1.Button3Click(Sender: TObject);
var
  Address: NativeUInt;
begin
  Memo1.Clear;
  Memo1.Lines.Add('MOV             X0, X26');
  Memo1.Lines.Add('MOV             X4, X24');
  Memo1.Lines.Add('MOV             X5, X25');
  Memo1.Lines.Add('MOV             X6, X21');
  Memo1.Lines.Add('MOV             X7, X23');
  Memo1.Lines.Add('BL              sub_123458');

  Address := StrToInt('$' + Trim(Edit1.Text));
  with TKeystone.Create do
  begin
    try
      SetSymResolverCb(@sym_resolver);
      if Assemble(Memo1.Text, Address) then
      begin
        Memo2.Text := EncodeStr(True);
      end
      else
        Memo2.Text := ErrorStr;
    finally
      Free;
    end;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  i: Integer;
  Address: NativeUInt;
begin
  Memo1.Clear;
  Memo1.Lines.Add('MOV             X0, X26');
  Memo1.Lines.Add('MOV             X4, X24');
  Memo1.Lines.Add('MOV             X5, X25');
  Memo1.Lines.Add('MOV             X6, X21');
  Memo1.Lines.Add('MOV             X7, X23');
  Memo1.Lines.Add('BL              loc_654321');

  Address := StrToInt('$' + Trim(Edit1.Text));
  with TKeystone.Create do
  begin
    Memo2.Clear;
    try
      SetSymResolverCb(@sym_resolver2);
      for i := 0 to Memo1.Lines.Count - 1 do
      begin
        if Assemble(Memo1.Lines[i], Address) then
          Memo2.Lines.Add(Format('%.8x | %s', [Address, EncodeStr(False)]))
        else
        begin
          Memo2.Lines.Add(Format('%.8x | %s', [Address, ErrorStr]));
          break;
        end;
        Inc(Address, EncodingSize);
      end;
    finally
      Free;
    end;
  end;
end;
{$ENDREGION}

initialization
  ReportMemoryLeaksOnShutdown := True;

end.
