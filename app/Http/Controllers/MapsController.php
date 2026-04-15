<?php

namespace App\Http\Controllers;

class MapsController extends Controller
{
    public function index()
    {
        $location =
        $lat = $request->input('latitude');

        return view('home', compact('cords'));
    }
}
