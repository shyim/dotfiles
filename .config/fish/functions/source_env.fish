function source_env
    for line in (cat $argv[1])
        set line (string trim $line)
        
        # Skip empty lines and comments
        if test -z "$line" || string match -q "#*" $line
            continue
        end

        set -l kv (string split -m 1 = $line)
        set -l key (string trim $kv[1])
        set -l value (string trim -c '"' -c "'" $kv[2])
        
        # Set environment variable
        set -gx $key $value
        export $key
    end
end
