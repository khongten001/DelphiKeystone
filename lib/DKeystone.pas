unit DKeystone;

(* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

  \Delphi Keystone 1.0\
  \SERHAT SARICA\

  \http://www.keystone-engine.org\
  Keystone is a lightweight multi-platform, multi-architecture
  assembler framework.

  Highlight features:
    Multi-architecture, with support for Arm, Arm64 (AArch64/Armv8),
    Ethereum Virtual Machine, Hexagon, Mips, PowerPC, Sparc,
    SystemZ, & X86 (include 16/32/64bit).
    Clean/simple/lightweight/intuitive architecture-neutral API.
    Implemented in C/C++ languages, with bindings for Java, Masm,
    Visual Basic, C#, PowerShell, Perl, Python, NodeJS, Ruby, Go,
    Rust, Haskell, OCaml & Delphi available :).
    Native support for Windows & *nix (with Mac OSX, Linux,
    *BSD & Solaris confirmed).
    Thread-safe by design.

 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *)

interface

{$MINENUMSIZE 4}

uses
  Classes, SysUtils;

{$REGION 'KEYSTONE HEADER'}

const
  KS_API_MAJOR = 0;
  KS_API_MINOR = 9;
  KS_VERSION_MAJOR = KS_API_MAJOR;
  KS_VERSION_MINOR = KS_API_MINOR;
  KS_VERSION_EXTRA = 2;

  KS_ERR_ASM = 128;
  KS_ERR_ASM_ARCH = 512;

type
  // Forward declarations
  PPByte = ^PByte;
  PUInt64 = ^UInt64;
  PNativeUInt = ^NativeUInt;
  Pks_struct = Pointer;
  PPks_struct = ^Pks_struct;

  Pks_engine = Pointer;
  PPks_engine = ^Pks_engine;

  ks_arch = (
    KS_ARCH_ARM = 1,
    KS_ARCH_ARM64 = 2,
    KS_ARCH_MIPS = 3,
    KS_ARCH_X86 = 4,
    KS_ARCH_PPC = 5,
    KS_ARCH_SPARC = 6,
    KS_ARCH_SYSTEMZ = 7,
    KS_ARCH_HEXAGON = 8,
    KS_ARCH_EVM = 9,
    KS_ARCH_MAX = 10);
  Pks_arch = ^ks_arch;

  ks_mode = (
    KS_MODE_LITTLE_ENDIAN = 0,
    KS_MODE_BIG_ENDIAN = 1073741824,
    KS_MODE_ARM = 1,
    KS_MODE_THUMB = 16,
    KS_MODE_V8 = 64,
    KS_MODE_MICRO = 16,
    KS_MODE_MIPS3 = 32,
    KS_MODE_MIPS32R6 = 64,
    KS_MODE_MIPS32 = 4,
    KS_MODE_MIPS64 = 8,
    KS_MODE_16 = 2,
    KS_MODE_32 = 4,
    KS_MODE_64 = 8,
    KS_MODE_PPC32 = 4,
    KS_MODE_PPC64 = 8,
    KS_MODE_QPX = 16,
    KS_MODE_SPARC32 = 4,
    KS_MODE_SPARC64 = 8,
    KS_MODE_V9 = 16);
  Pks_mode = ^ks_mode;

  ks_err = (
    KS_ERR_OK = 0,
    KS_ERR_NOMEM = 1,
    KS_ERR_ARCH = 2,
    KS_ERR_HANDLE = 3,
    KS_ERR_MODE = 4,
    KS_ERR_VERSION = 5,
    KS_ERR_OPT_INVALID = 6,
    KS_ERR_ASM_EXPR_TOKEN = 128,
    KS_ERR_ASM_DIRECTIVE_VALUE_RANGE = 129,
    KS_ERR_ASM_DIRECTIVE_ID = 130,
    KS_ERR_ASM_DIRECTIVE_TOKEN = 131,
    KS_ERR_ASM_DIRECTIVE_STR = 132,
    KS_ERR_ASM_DIRECTIVE_COMMA = 133,
    KS_ERR_ASM_DIRECTIVE_RELOC_NAME = 134,
    KS_ERR_ASM_DIRECTIVE_RELOC_TOKEN = 135,
    KS_ERR_ASM_DIRECTIVE_FPOINT = 136,
    KS_ERR_ASM_DIRECTIVE_UNKNOWN = 137,
    KS_ERR_ASM_DIRECTIVE_EQU = 138,
    KS_ERR_ASM_DIRECTIVE_INVALID = 139,
    KS_ERR_ASM_VARIANT_INVALID = 140,
    KS_ERR_ASM_EXPR_BRACKET = 141,
    KS_ERR_ASM_SYMBOL_MODIFIER = 142,
    KS_ERR_ASM_SYMBOL_REDEFINED = 143,
    KS_ERR_ASM_SYMBOL_MISSING = 144,
    KS_ERR_ASM_RPAREN = 145,
    KS_ERR_ASM_STAT_TOKEN = 146,
    KS_ERR_ASM_UNSUPPORTED = 147,
    KS_ERR_ASM_MACRO_TOKEN = 148,
    KS_ERR_ASM_MACRO_PAREN = 149,
    KS_ERR_ASM_MACRO_EQU = 150,
    KS_ERR_ASM_MACRO_ARGS = 151,
    KS_ERR_ASM_MACRO_LEVELS_EXCEED = 152,
    KS_ERR_ASM_MACRO_STR = 153,
    KS_ERR_ASM_MACRO_INVALID = 154,
    KS_ERR_ASM_ESC_BACKSLASH = 155,
    KS_ERR_ASM_ESC_OCTAL = 156,
    KS_ERR_ASM_ESC_SEQUENCE = 157,
    KS_ERR_ASM_ESC_STR = 158,
    KS_ERR_ASM_TOKEN_INVALID = 159,
    KS_ERR_ASM_INSN_UNSUPPORTED = 160,
    KS_ERR_ASM_FIXUP_INVALID = 161,
    KS_ERR_ASM_LABEL_INVALID = 162,
    KS_ERR_ASM_FRAGMENT_INVALID = 163,
    KS_ERR_ASM_INVALIDOPERAND = 512,
    KS_ERR_ASM_MISSINGFEATURE = 513,
    KS_ERR_ASM_MNEMONICFAIL = 514
  );
  Pks_err = ^ks_err;

  ks_opt_type = (
    KS_OPT_SYNTAX = 1,
    KS_OPT_SYM_RESOLVER = 2);
  Pks_opt_type = ^ks_opt_type;

  ks_opt_value = (
    KS_OPT_SYNTAX_INTEL = 1,
    KS_OPT_SYNTAX_ATT = 2,
    KS_OPT_SYNTAX_NASM = 4,
    KS_OPT_SYNTAX_MASM = 8,
    KS_OPT_SYNTAX_GAS = 16,
    KS_OPT_SYNTAX_RADIX16 = 32);
  Pks_opt_value = ^ks_opt_value;

  ks_err_asm_arm64 = (
    KS_ERR_ASM_ARM64_INVALIDOPERAND = 512,
    KS_ERR_ASM_ARM64_MISSINGFEATURE = 513,
    KS_ERR_ASM_ARM64_MNEMONICFAIL = 514);
  Pks_err_asm_arm64 = ^ks_err_asm_arm64;

  ks_err_asm_evm = (
    KS_ERR_ASM_EVM_INVALIDOPERAND = 512,
    KS_ERR_ASM_EVM_MISSINGFEATURE = 513,
    KS_ERR_ASM_EVM_MNEMONICFAIL = 514);
  Pks_err_asm_evm = ^ks_err_asm_evm;

  ks_err_asm_hexagon = (
    KS_ERR_ASM_HEXAGON_INVALIDOPERAND = 512,
    KS_ERR_ASM_HEXAGON_MISSINGFEATURE = 513,
    KS_ERR_ASM_HEXAGON_MNEMONICFAIL = 514);
  Pks_err_asm_hexagon = ^ks_err_asm_hexagon;

  ks_err_asm_mips = (
    KS_ERR_ASM_MIPS_INVALIDOPERAND = 512,
    KS_ERR_ASM_MIPS_MISSINGFEATURE = 513,
    KS_ERR_ASM_MIPS_MNEMONICFAIL = 514);
  Pks_err_asm_mips = ^ks_err_asm_mips;

  ks_err_asm_ppc = (
    KS_ERR_ASM_PPC_INVALIDOPERAND = 512,
    KS_ERR_ASM_PPC_MISSINGFEATURE = 513,
    KS_ERR_ASM_PPC_MNEMONICFAIL = 514);
  Pks_err_asm_ppc = ^ks_err_asm_ppc;

  ks_err_asm_sparc = (
    KS_ERR_ASM_SPARC_INVALIDOPERAND = 512,
    KS_ERR_ASM_SPARC_MISSINGFEATURE = 513,
    KS_ERR_ASM_SPARC_MNEMONICFAIL = 514);
  Pks_err_asm_sparc = ^ks_err_asm_sparc;

  ks_err_asm_systemz = (
    KS_ERR_ASM_SYSTEMZ_INVALIDOPERAND = 512,
    KS_ERR_ASM_SYSTEMZ_MISSINGFEATURE = 513,
    KS_ERR_ASM_SYSTEMZ_MNEMONICFAIL = 514);
  Pks_err_asm_systemz = ^ks_err_asm_systemz;

  ks_err_asm_x86 = (
    KS_ERR_ASM_X86_INVALIDOPERAND = 512,
    KS_ERR_ASM_X86_MISSINGFEATURE = 513,
    KS_ERR_ASM_X86_MNEMONICFAIL = 514);
  Pks_err_asm_x86 = ^ks_err_asm_x86;

  ks_err_asm_arm = (
    KS_ERR_ASM_ARM_INVALIDOPERAND = 512,
    KS_ERR_ASM_ARM_MISSINGFEATURE = 513,
    KS_ERR_ASM_ARM_MNEMONICFAIL = 514);
  Pks_err_asm_arm = ^ks_err_asm_arm;

type
  Tks_sym_resolver_callback = function(const symbol: PUTF8Char; value: PUInt64): Boolean; cdecl;

{$ENDREGION}

type
  EDLLLoadError = class(Exception);

  { TKeystone }
  TKeystone = class
  private
    { private declarations }
    ks: Pks_engine;
    encoding: PByte;
    encoding_size: NativeUInt;
    stat_count: NativeUInt;
    function GetData: TBytes;
    function GetErrorStr: string;
    function GetErrNo: Integer;
  protected
    { protected declarations }
  public
    { public declarations }
    constructor Create(Arch: ks_arch = KS_ARCH_ARM64; Mode: ks_mode = KS_MODE_LITTLE_ENDIAN);
    destructor Destroy; override;

    function Option(OptTyp: ks_opt_type; Value: NativeUInt): Boolean;
    function Assemble(&Asm: string; Address: NativeUInt = 0): Boolean;
    function EncodeStr(InsertSpaces: Boolean = False): string;
    procedure SetSymResolverCb(cbFnc: Tks_sym_resolver_callback);
    function Version: string;

    property Data: TBytes read GetData;
    property EncodingSize: NativeUInt read encoding_size;
    property StatCount: NativeUInt read stat_count;
    property ErrorNo: Integer read GetErrNo;
    property ErrorStr: string read GetErrorStr;
  end;

  { TKeystoneBytesHelper }
  TKeystoneBytesHelper = record helper for TBytes
    function ToHex(InsertSpaces: Boolean = False): string;
  end;

implementation

uses
  Windows;

type
  Tks_version = function (major: PCardinal; minor: PCardinal): Cardinal; cdecl;
  Tks_arch_supported = function (arch: ks_arch): Boolean; cdecl;
  Tks_open = function (arch: ks_arch; mode: Integer; ks: PPks_engine): ks_err; cdecl;
  Tks_close = function (ks: Pks_engine): ks_err; cdecl;
  Tks_errno = function (ks: Pks_engine): ks_err; cdecl;
  Tks_strerror = function (code: ks_err): PUTF8Char; cdecl;
  Tks_option = function (ks: Pks_engine; &type: ks_opt_type; value: NativeUInt): ks_err; cdecl;
  Tks_asm = function (ks: Pks_engine; const &string: PUTF8Char; address: UInt64; encoding: PPByte; encoding_size: PNativeUInt; stat_count: PNativeUInt): ks_err; cdecl;
  Tks_free = procedure (p: PByte); cdecl;

var
  FLibHandle: THandle;

  ks_version: Tks_version;
  ks_arch_supported: Tks_arch_supported;
  ks_open: Tks_open;
  ks_close: Tks_close;
  ks_errno: Tks_errno;
  ks_strerror: Tks_strerror;
  ks_option: Tks_option;
  ks_asm: Tks_asm;
  ks_free: Tks_free;

function DataToHex(Data: PByte; Size: Integer;
  InsertSpaces: Boolean = False): string; overload;
const
  Convert: array [0 .. 15] of Char = '0123456789ABCDEF';
var
  i: Integer;
  P: PChar;
begin
  if InsertSpaces then
    SetLength(Result, Size * 3)
  else
    SetLength(Result, Size * 2);
  P := @Result[Low(Result)];
  for i := 0 to Size - 1 do
  begin
    P^ := Convert[Data[i] shr 4];  Inc(P);
    P^ := Convert[Data[i] and $F]; Inc(P);
    if InsertSpaces then
    begin
      P^ := ' '; Inc(P);
    end;
  end;
end;

{ TKeystone }

constructor TKeystone.Create(Arch: ks_arch; Mode: ks_mode);
begin
  inherited Create;

  if not(ks_open(Arch, Integer(Mode), @ks) = KS_ERR_OK) then
    raise Exception.Create('failed on open');
end;

destructor TKeystone.Destroy;
begin
  ks_close(ks);

  inherited;
end;

function TKeystone.Option(OptTyp: ks_opt_type; Value: NativeUInt): Boolean;
begin
  Result := False;
  if ks_option(ks, OptTyp, Value) = KS_ERR_OK then
    Result := True;
end;

procedure TKeystone.SetSymResolverCb(cbFnc: Tks_sym_resolver_callback);
begin
  Option(KS_OPT_SYM_RESOLVER, NativeUInt(@cbFnc));
end;

function TKeystone.Assemble(&Asm: string; Address: NativeUInt): Boolean;
var
  err: ks_err;
begin
  stat_count := 0;
  encoding_size := 0;
  try
    err := ks_asm(ks, PAnsiChar(AnsiString(&Asm)), Address, @encoding,
      @encoding_size, @stat_count);

    Result := err = KS_ERR_OK;
  finally
    ks_free(encoding);
  end;
end;

function TKeystone.EncodeStr(InsertSpaces: Boolean): string;
begin
  if encoding_size > 0 then
  Result := DataToHex(encoding, encoding_size, InsertSpaces) else
  Result := '';
end;

function TKeystone.Version: string;
var
  m,n: Cardinal;
begin
  ks_version(@m, @n);
  Result := Format('%u.%u', [m, n]);
end;

function TKeystone.GetData: TBytes;
begin
  SetLength(Result, encoding_size);
  Move(encoding[0], Result[0], encoding_size);
end;

function TKeystone.GetErrNo: Integer;
begin
  Result := Integer(ks_errno(ks));
end;

function TKeystone.GetErrorStr: string;
begin
  Result := string(ks_strerror(ks_errno(ks)));
end;

{ TKeystoneBytesHelper }

function TKeystoneBytesHelper.ToHex(InsertSpaces: Boolean): string;
begin
  Result := DataToHex(@Self[0], Length(Self), InsertSpaces);
end;


{ Init }

procedure LoadLib;
begin
  FLibHandle := LoadLibrary({$IFDEF CPUX86}'keystone.dll'{$ELSE}'keystoneX64.dll'{$ENDIF});
  if FLibHandle = 0 then
      raise EDLLLoadError.Create('Unable to Load DLL');

  @ks_version := GetProcAddress(FLibHandle, 'ks_version');
  @ks_arch_supported := GetProcAddress(FLibHandle, 'ks_arch_supported');
  @ks_open := GetProcAddress(FLibHandle, 'ks_open');
  @ks_close := GetProcAddress(FLibHandle, 'ks_close');
  @ks_errno := GetProcAddress(FLibHandle, 'ks_errno');
  @ks_strerror := GetProcAddress(FLibHandle, 'ks_strerror');
  @ks_option := GetProcAddress(FLibHandle, 'ks_option');
  @ks_asm := GetProcAddress(FLibHandle, 'ks_asm');
  @ks_free := GetProcAddress(FLibHandle, 'ks_free');
end;

procedure FreeLib;
begin
  if FLibHandle <> 0 then
    FreeLibrary(FLibHandle);

  @ks_version := nil;
  @ks_arch_supported := nil;
  @ks_open := nil;
  @ks_close := nil;
  @ks_errno := nil;
  @ks_strerror := nil;
  @ks_option := nil;
  @ks_asm := nil;
  @ks_free := nil;
end;

initialization LoadLib;
finalization FreeLib;

end.
