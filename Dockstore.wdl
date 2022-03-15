version 1.0

workflow echo {
    input {
        String message1
        String message2
        String message3
    }

    call echoMessage1 {
        input:
            message1 = message1
    }

    Boolean done1 = echoMessage1.done

    call echoMessage2 {
        input:
            message2 = message2,
            previousDone = done1
    }

    Boolean done2 = echoMessage2.done

    call echoMessage3 {
        input:
            message3 = message3,
            previousDone = done2
    }
}

task echoMessage1 {
    input {
        String message1
    }

    command {
        echo "STDOUT: writing message 1 to message_1.txt"
        echo "STDERR: writing message 1 to message_1.txt" >&2
        echo "Current message: ${message1}" > message_1.txt
    }

    runtime {
        docker: "ubuntu:18.04"
    }

    output {
        File message1_output = "message_1.txt"
        Boolean done = true
    }
}

task echoMessage2 {
    input {
        String message2
        Boolean previousDone
    }

    command {
        echo "STDOUT: writing message 2 to message_2.txt"
        echo "STDERR: writing message 2 to message_2.txt" >&2
        echo "Current message: ${message2}" > message_2.txt
    }

    runtime {
        docker: "ubuntu:18.04"
    }

    output {
        File message2_output = "message_2.txt"
        Boolean done = true
    }
}

task echoMessage3 {
    input {
        String message3
        Boolean previousDone
    }

    command {
        echo "STDOUT: writing message 3 to message_3.txt"
        echo "STDERR: writing message 3 to message_3.txt" >&2
        echo "Current message: ${message3}" > message_3.txt
    }

    runtime {
        docker: "ubuntu:18.04"
    }

    output {
        File message3_output = "message_3.txt"
        Boolean done = true
    }
}
