#!/bin/bash
error(){
    echo ERROR: $@
}

parse(){
    # parse template file form stdin
    while IFS= read -r line ; do
        while [[ "$line" =~ (\$\{TPL_[a-zA-Z_0-9][a-zA-Z_0-9]*\}) ]] ; do
            LHS=${BASH_REMATCH[1]}
            RHS="$(eval echo "\"$LHS\"")"
            [[ -n $RHS ]] || error "$LHS is not set"
            line=${line//$LHS/$RHS}
        done
        echo "$line"
    done
}

tpl_file="$1"
out_file="${tpl_file/.tpl/}"

echo "Preprocessor: $tpl_file ---> $out_file"

cat $tpl_file | parse > $out_file
