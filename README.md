# Somewhat Reproducible Docker(?) Bug

This repo contains code to create a docker image that behaves
differently when it is run. The image is `ahawkins/rebar-bug`.
Execute `docker run --rm -it ahawkins/rebar-bug` and see what happens.
Ocassionally the process will hang to complete.

When the image runs successfully you'll see:

    vagrant@vagrant-ubuntu-trusty-64:~$ docker run --rm -it ahawkins/rebar-bug
    DEBUG: Consult config file "/usr/src/app/rebar.config"
    DEBUG: Rebar location: "/usr/bin/rebar"
    DEBUG: Consult config file "/usr/src/app/src/request_logger.app.src"
    DEBUG: Available deps: []
    DEBUG: Missing deps  : []
    DEBUG: Plugins requested while processing /usr/src/app: []
    DEBUG: Predirs: []
    ==> app (eunit)
    DEBUG: Matched required ERTS version: 6.2 -> .*
    DEBUG: Matched required OTP release: 17 -> .*
    DEBUG: Min OTP version unconfigured
    DEBUG: Triq availability: false
    DEBUG: PropEr availability: false
    DEBUG: QuickCheck availability: false
    INFO:  sh info:
            cwd: "/usr/src/app"
            cmd: cp -R src/request_logger_app.erl src/request_logger_sup.erl test/truth_test.erl ".eunit"
    DEBUG:  opts: [{use_stdout,false},abort_on_error]
    DEBUG: Port Cmd: "cp -R src/request_logger_app.erl src/request_logger_sup.erl test/truth_test.erl \".eunit\""
    Port Opts: [exit_status,{line,16384},use_stdio,stderr_to_stdout,hide]
    DEBUG: erl_opts [{d,'TEST'},debug_info]
    DEBUG: Files dependent on src/request_logger_app.erl: []
    DEBUG: Files dependent on src/request_logger_sup.erl: []
    DEBUG: Files dependent on test/truth_test.erl: []
    DEBUG: Files to compile first: []
    DEBUG: Starting 3 compile worker(s)
    DEBUG: Dependencies of src/request_logger_app.erl: []
    DEBUG: Dependencies of src/request_logger_sup.erl: []
    DEBUG: Dependencies of test/truth_test.erl:
    ["/usr/lib/erlang/lib/eunit-2.2.8/include/eunit.hrl"]
    Compiled src/request_logger_app.erl
    Compiled src/request_logger_sup.erl
    DEBUG: Worker exited cleanly
    Compiled test/truth_test.erl
    DEBUG: Worker exited cleanly
    DEBUG: Worker exited cleanly
    ======================== EUnit ========================
    module 'request_logger_sup'
    module 'request_logger_app'
    truth_test: truth_test (module 'truth_test')...ok
    =======================================================
      Test passed.
    DEBUG: Reconstruct kernel [{error_logger,tty}]
    DEBUG: Reconstruct rebar []
    DEBUG: Reconstruct crypto []
    DEBUG: Reconstruct stdlib []
    DEBUG: No processes to kill
    DEBUG: Postdirs: []

Occassionally the process will hang and never complete. You'll see
this log:

    vagrant@workstation:/vagrant$ docker run --rm -it ahawkins/rebar-bug
    DEBUG: Consult config file "/usr/src/app/rebar.config"
    DEBUG: Rebar location: "/usr/bin/rebar"
    DEBUG: Consult config file "/usr/src/app/src/request_logger.app.src"
    DEBUG: Available deps: []
    DEBUG: Missing deps  : []
    DEBUG: Plugins requested while processing /usr/src/app: []
    DEBUG: Predirs: []
    ==> app (eunit)
    DEBUG: Matched required ERTS version: 6.2 -> .*
    DEBUG: Matched required OTP release: 17 -> .*
    DEBUG: Min OTP version unconfigured
    DEBUG: Triq availability: false
    DEBUG: PropEr availability: false
    DEBUG: QuickCheck availability: false
    INFO:  sh info:
            cwd: "/usr/src/app"
            cmd: cp -R src/request_logger_app.erl src/request_logger_sup.erl test/truth_test.erl ".eunit"
    DEBUG:  opts: [{use_stdout,false},abort_on_error]
    DEBUG: Port Cmd: "cp -R src/request_logger_app.erl src/request_logger_sup.erl test/truth_test.erl \".eunit\""
    Port Opts: [exit_status,{line,16384},use_stdio,stderr_to_stdout,hide]

    ^^^^^^^^^^ Process just hangs here

I have tried to make this 100% reproducable, but I have failed. It
only happens occasionally. It seems to happen regardless of docker
version & host OS.
