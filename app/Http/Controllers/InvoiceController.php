<?php

namespace App\Http\Controllers;
use Barryvdh\DomPDF\Facade\Pdf;

use Illuminate\Http\Request;

class InvoiceController extends Controller
{
    public function download(Request $request)
    {
        $data =['name'=> $request->name,];
        return pdf::loadView('pdf.invoice', $data)->download('factuur.pdf');

    }

    public function index()
    {
        return view('invoice');
    }
}
