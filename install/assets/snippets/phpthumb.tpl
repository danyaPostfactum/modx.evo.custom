//<?php
/**
 * phpthumb
 * 
 * Работа к картинками резайз эфекты - через снипет
 *
 * @category 	snippet
 * @version 	1.0
 * @license 	http://www.gnu.org/copyleft/gpl.html GNU Public License (GPL)
 * @internal	@properties 
 * @internal	@modx_category add
 * @author      Karandash
 */

//[[phpthumb? &input=`[+tvimagename+]` &options=`w_255,h=200`]]
if($input == '' || !file_exists($_SERVER['DOCUMENT_ROOT']."/".$input))
    {echo 'assets/snippets/phpthumbof/noimage.png';}
else{   
     $replace  = Array("," => "&", "_" => "=");
    $options  = strtr($options, $replace);
    $options .= "&f=jpg&q=96";
    $opt = $options;
    //$pt = $modx->getPageInfo($modx->documentIdentifier);
    require_once $_SERVER['DOCUMENT_ROOT']."/assets/snippets/phpthumbof/phpthumb.class.php";
    $phpThumb = new phpthumb();
    $phpThumb->setSourceFilename($input); 
    $options = explode("&", $options);
    foreach ($options as $value) {
       $thumb = explode("=", $value);
       $phpThumb->setParameter($thumb[0], $thumb[1]);
    }
    $outputFilename = $_SERVER['DOCUMENT_ROOT']."/assets/cache/phpthumbof/".md5($input.$opt).".jpg";
    if (!file_exists($outputFilename))
       if ($phpThumb->GenerateThumbnail())
           $phpThumb->RenderToFile($outputFilename) ;
    $res = explode("/assets", $outputFilename); 
    $res = "/assets".$res[1];
    return $res;
}
