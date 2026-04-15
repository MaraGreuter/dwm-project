<?php

namespace App\Http\Controllers;

use Barryvdh\DomPDF\Facade\Pdf;
use Illuminate\Http\Request;

class InvoiceController extends Controller
{
    public function download(Request $request)
    {
        $data = ['name' => $request->name,
            'address' => $request->address,
            'address' => $request->plaats,

        ];

        return Pdf::loadView('pdf.invoice', $data)->download('factuur.pdf');

    }

    public function index()
    {
        return view('invoice');
    }
}
