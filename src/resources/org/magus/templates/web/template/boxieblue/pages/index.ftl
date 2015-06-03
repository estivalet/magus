<%@include file="/header.jsp" %>

<h3>Examples:</h3>

<div class="box box-50 altbox">
                    <div class="boxin">
                        <div class="header">
                            <h3>Forms with fieldsets, plain layout</h3>
                        </div>
                        <form class="fields" action="" method="post" enctype="multipart/form-data"><!-- Forms (plain layout, cleaner) -->
                            <fieldset>
                                <legend><strong>Legend</strong></legend>
                                <div class="msg msg-ok">
                                    <p>I'm a <strong>success</strong> message and I'm proud of it!</p>
                                </div>
                                <label for="some21">Input field:</label>
                                <input class="txt" type="text" id="some21" name="some21" size="30" />
                                <small>A little description.</small>
                                    
                                <label class="error" for="some23">Input field:</label>
                                <input class="txt error" type="text" id="some23" name="some23" size="30" value="error" />
                                <small>An error description.</small>
                                
                                <label for="some22">Textarea:</label>
                                <textarea name="some22" id="some22" cols="40" rows="5"></textarea>
                                
                                <label for="some24">File input:</label>
                                <input class="file" type="file" id="some24" name="some24" /> <span class="loading">uploading…</span><!-- OR <img src="css/img/upload.gif" alt="" /> -->
                                    
                                <label for="some210">Select box:</label>
                                <select id="some210" name="some210">
                                    <option value="val1">select …</option>
                                    <option value="val1">… something</option>
                                </select>
                                
                                <div class="sep">
                                    <label class="check"><input class="check" type="checkbox" id="some25" name="some25" value="true" checked="checked" />Checkbox 1</label>
                                    <label class="check"><input class="check" type="checkbox" id="some26" name="some26" value="true" />Checkbox 2</label>
                                </div>
                                
                                <div class="sep">
                                    <label class="radio"><input class="radio" type="radio" id="some27" name="some278" value="true" />Radio 1</label>
                                    <label class="radio"><input class="radio" type="radio" id="some28" name="some278" value="true" />Radio 2</label>
                                </div>                                  
                                
                                <div class="sep">
                                    <input class="button" type="submit" value="Submit" />
                                    <input class="button altbutton" type="submit" value="Submit emphasized" />
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
                
                                <div class="box box-50">
                    <div class="boxin">
                        <div class="header">
                            <h3>Forms, basic layout</h3>
                        </div>
                        <form class="basic" action="" method="post" enctype="multipart/form-data"><!-- Default basic forms -->
                            <div class="inner-form">
                                <!-- error and information messages -->
                                <div class="msg msg-ok"><p>I'm a <strong>success</strong> message and I'm proud of it!</p></div>
                                <div class="msg msg-error"><p>I'm an <strong>error</strong> message and I'm proud of it!</p></div>
                                <div class="msg msg-warn"><p>I'm a <strong>warning</strong> message and I'm proud of it!</p></div>
                                <div class="msg msg-info"><p>I'm an <strong>info</strong> message and I'm proud of it!</p></div>
                                    <dl>
                                        <dt><label for="some1">Input field:</label></dt>
                                        <dd>
                                            <input class="txt" type="text" id="some1" name="some1" />
                                            <small>A little description.</small>
                                        </dd>
                                    
                                        <dt><label class="error" for="some3">Input field:</label></dt>
                                        <dd>
                                            <input class="txt error" type="text" id="some3" name="some3" value="error" /><!-- class error for wrong filled inputs -->
                                            <small>An error description.</small>
                                        </dd>
                                    
                                        <dt class="ttop"><label for="some2">Textarea:</label></dt><!-- .ttop for vertical-align: top -->
                                        <dd><textarea name="some2" id="some2" cols="20" rows="5"></textarea></dd>
                                    
                                        <dt><label for="some4">File input:</label></dt>
                                        <dd>
                                            <input class="file" type="file" id="some4" name="some4" />
                                            <span class="loading">uploading…</span><!-- OR <img src="css/img/upload.gif" alt="" /> --><!-- uploading animation -->
                                        </dd>
                                    
                                        <dt><label for="some10">Select box:</label></dt>
                                        <dd>
                                            <select id="some10" name="some10">
                                                <option value="val1">select …</option>
                                                <option value="val1">… something</option>
                                            </select>
                                        </dd>
                                    
                                        <dt></dt>
                                        <dd>
                                            <label class="check"><input class="check" type="checkbox" id="some5" name="some5" value="true" checked="checked" />Checkbox 1</label>
                                            <label class="check"><input class="check" type="checkbox" id="some6" name="some6" value="true" />Checkbox 2</label>
                                        </dd>
                                    
                                        <dt></dt>
                                        <dd>
                                            <label class="radio"><input class="radio" type="radio" id="some7" name="some78" value="true" />Radio 1</label>
                                            <label class="radio"><input class="radio" type="radio" id="some8" name="some78" value="true" />Radio 2</label>
                                        </dd>
                                    
                                        <dt></dt>
                                        <dd>
                                            <input class="button" type="submit" value="Submit emphasized" />
                                            <input class="button altbutton" type="submit" value="Submit" />
                                        </dd>
                                    </dl>
                            </div>
                        </form>
                    </div>
                </div>
        </div> <!-- content_res end -->
    </div> <!-- content end -->
    
<#include "footer.ftl">


