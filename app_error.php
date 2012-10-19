<?php
    class AppError extends ErrorHandler {
        function session_expired($param){            
            $this->controller->set($data = Array("data"=>$param));            
            $this->_outputMessage('session_expired');
        }
    }
?>
