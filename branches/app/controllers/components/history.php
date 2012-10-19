<?php

/**
 * Realiza el tipico history.back de javascript implementado en php para mantener la session 
 * @author Luis Marin
 * @access Public 
 * @type Componente
 * @email ninja.aoshi@gmail.com
 * @url http://www.pokodetodo.com/node/47
 * @since 17.07.2011
 */

class HistoryComponent extends Object
{
    var $data = array();
    var $started = false;
    var $controller = true;
    function startup(&$controller)
    {
        if (!$this->started) {
            $this->started = true;
            $this->controller = $controller;
        }
    }
    /**
     * @description: inicia el grupo de paginas con un nombre único que lo identifica
     * @return null
     * @var cambia el atributo data
     * @private
     */
    private function InitGroupPages($page, $post, $name)
    {
        $this->data = array("$name" => array(array("url" => $page, "post_json" =>
            json_encode($post))));
    }

    /**
     * @description: inicia una nueva página del mismo grupo del nombre ($name) que se pasa por parametro
     * @return null
     * @var cambia el atributo data
     * @private
     */
    private function NewPage($page, $post, $name)
    {
        $i = count($this->data["$name"]) + 1;
        $i--;
        if ($i < 0)
            $i = 0;
        $this->data["$name"][$i]["url"] = $page;
        $this->data["$name"][$i]["post_json"] = json_encode($post);
    }

    /**
     * @description: inicia un nuevo grupo de paginas
     * @return null
     * @var cambia el atributo data
     * @private
     */
    private function NewGroupPages($page, $post, $name)
    {
        $this->data["$name"][0]["url"] = $page;
        $this->data["$name"][0]["post_json"] = json_encode($post);
    }

    /**
     * @description: verifica si existe alguna url repetida
     * @return null
     * @var cambia el atributo data
     * @private
     */
    private function CheckUrl($urlBase, $urlMer)
    {

        $return = false;
        if (strpos($urlBase, $urlMer)) {
            $return = true;
        } else
            if (strpos(strtoupper($urlBase), (preg_replace("/_/", "", strtoupper($urlMer))))) {
                $return = true;
            } else
                if ((trim(preg_replace("/_/", "", strtoupper($urlBase)))) == (trim(preg_replace
                    ("/_/", "", strtoupper($urlMer))))) {
                }

        return $return;
    }

    /**
     * @description: Destruye el grupo de páginas
     * @return null
     * @var cambia el atributo data
     * @private
     */
    private function DestroyGroupPages($name)
    {
        unset($this->data[$name]);
        $this->data = array_values($this->data);
        $this->SetDataSession();
    }

    /**
     * @description: insertando datos en la session
     * @return null
     * @var cambia el atributo data
     * @private
     */
    private function SetDataSession()
    {
        $this->controller->Session->write($this->controller->group_session . ".history",
            $this->data);
    }

    /**
     * @description: guardando el historico en la session, para mantener la historia de la página
     * @return null
     * @var cambia el atributo data
     * @param $name: describe el nombre que tendra la sessión
     * @public
     */
    function SetHistory($name)
    {
        $page = $this->controller->referer();
        if (!strpos($page, "/history:true")) {
            $page = $page . "/history:true";
        }
        $post = $_POST;

        if (count($post) > 0) {
            if (!$this->controller->Session->check($this->controller->group_session .
                ".history")) {
                $this->InitGroupPages($page, $post, $name);
            } else {

                $this->data = $this->controller->Session->read($this->controller->group_session .
                    ".history");

                if (array_key_exists($name, $this->data)) {
                    $new_page = true;
                    for ($i = 0; $i < count($this->data["$name"]); $i++) {
                        $page_session = $this->data["$name"];

                        $conf = $page_session[$i];

                        if ($this->CheckUrl($page, $conf["url"])) {
                            echo $page;
                            $this->data["$name"][$i]["post_json"] = json_encode($post);
                            $new_page = false;
                            break;
                        }
                    }
                    if ($new_page) {
                        $this->NewPage($page, $post, $name);
                    }
                } else {
                    $this->NewGroupPages($page, $post, $name);
                }
            }

            $this->SetDataSession();
        }
    }

    /**
     * @description: obtiene el la información de la página que se encuentra guardada en la sessión
     * @return null
     * @var cambia el atributo data
     * @param $name: describe el nombre que tendra la sessión,
     * $destroy por defecto es false, se usa para destruir la sessión
     * @public
     */
    function GetHistory($name, $destroy = false)
    {
        $page = Router::url($this->controller->here);
        if (strpos($page, "history:true")) {
            if ($this->controller->Session->check($this->controller->group_session .
                ".history")) {

                $this->data = $this->controller->Session->read($this->controller->group_session .
                    ".history");
                for ($i = 0; $i < count($this->data[$name]); $i++) {
                    $page_session = $this->data[$name];
                    $conf = $page_session[$i];

                    if ($this->CheckUrl($page, $conf["url"])) {

                        return $conf["post_json"];
                    }
                }
            } else {
                return "{}";
            }
        } else {
            if ($destroy)
                $this->DestroyGroupPages($name);
            return "{}";
        }
    }

    public function GetHistoryData($name, $var_name)
    {
        $post = $_POST;
        if (count($post) > 0) {
            return $post[$var_name];
        }
        $obj_data = json_decode($this->GetHistory($name));
        return $obj_data->{"$var_name"};
    }
}
?>