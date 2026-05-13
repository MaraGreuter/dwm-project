<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;


class MapsController extends Controller
{
    public function index(Request $request)
    {
        $location =
        $lat = $request->input('latitude');

        return view('home', compact('lat'));
    }
}
