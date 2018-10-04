<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('accueil', function () {
    return view('accueil');
});

Route::get('/a-propos', function() {
	return view('a-propos');
});

Route::get('/statistiques', function() {
	return view('statistiques');
});

Route::get('/historique', function() {
	return view('historique');
});

Route::get('/saisi_de_mouvement', function() {
	return view('saisi_de_mouvement');
});

Route::get('/liste_articles', function() {
	return view('listes_articles');
});

Route::get('/creation_article', function() {
	return view('creation_article');
});

Route::get('/modification_article', function() {
	return view('modification_article');
});