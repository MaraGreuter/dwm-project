<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class MapsController extends Controller
{
    public function index(){
        $location =
        $lat = $request->input('latitude');
        return view('home', compact('cords'));
    }

}
