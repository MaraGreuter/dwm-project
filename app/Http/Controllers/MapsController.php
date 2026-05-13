<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;


class MapsController extends Controller
{
    public function index(request $request)
    {
        //$location =
        $lat = $request->input('latitude');

        return view('home');
    }
}
