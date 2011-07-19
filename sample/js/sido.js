/*
 * sido
 *
 * Simple download counter
 * The goal of this project is to create a way to count downloads easily and to create report.
 * Sido is multi project and multi version by project.
 * Sido manage event by project.
 *
 * Copyright (c) 2011 Antoine Froissart under the MIT License :
 *   http://www.opensource.org/licenses/mit-license.php
 *
 * Sample use :
 * <a href="./flot-0.7.zip" onclick="javascript:track('test1','nightly')">test</a>
 *
 */
  
/**
  * sido server url.
  * Change it before use.
  */
var Sido_Server = 'http://localhost:4567/' 
  
/**
  * Send a post
  *
  * @private
  */
  function post(path, data)
  {
    //send post
    var xhr_object = null; 
    if(window.XMLHttpRequest) // Firefox 
      xhr_object = new XMLHttpRequest(); 
    else if(window.ActiveXObject) // Internet Explorer 
      xhr_object = new ActiveXObject("Microsoft.XMLHTTP"); 
    else  // XMLHttpRequest not supported 
      return;
        
    
         
    xhr_object.open("POST", path, true);
    xhr_object.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    xhr_object.send(data);
  }
  
/**
  * Track a download
  *
  * @example track('project_one','nightly')
  * 
  * @param {string} project The name of the project
  * @param {string} version The version. Optional.
  */
  function track(project, version) {
    if (project == "")
      return;
    //concatenate with the server name
    var path = Sido_Server + project + "/track";
    var data = null;
    
    if(version != "") 
      data = "version=" + version;
    
    post(path, data);
  }
  
/**
  * Post an event
  *
  * @example add_event('project_one', 'beta test compaign begin')
  * 
  * @param {string} project The name of the project
  * @param {string} name The name of the event.
  */
  function add_event(project, name) {
    if (project == "" || name == "")
      return;
    
    //concatenate with the server name
    var path = Sido_Server + project + "/event";
    var data = "name=" + name;
         
    post(path, data);
  }