<?php

use App\Http\Controllers\InvoiceController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('home');
});

Route::post('/factuur/download', [InvoiceController::class, 'download']);
Route::get('/factuur', [InvoiceController::class, 'index']);
