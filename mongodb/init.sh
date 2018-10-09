# INIT DUMP EXECUTION
if test -n "$INIT_DUMP"; then
    echo "execute dump file"
	until mongo bandlist $INIT_DUMP; do sleep 5; done
fi

