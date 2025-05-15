$aria_args='--enable-rpc --rpc-listen-all=true --dir=C:\downloads'

if ($($args.Count) -eq 0) {
    $aria_args+=' -c -V --save-session=C:\downloads\aria2.session --save-session-interval=60 --input-file=C:\downloads\aria2.session'
} else {
    $aria_args+=" $args"
}

if (! ($env:RPC_PASS -eq $null)) {$aria_args+=" --rpc-secret=`"$env:RPC_PASS`""}

Invoke-Expression -Command ".\aria2c.exe $aria_args"
