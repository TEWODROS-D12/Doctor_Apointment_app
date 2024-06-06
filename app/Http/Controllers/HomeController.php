<?php

namespace App\Http\Controllers;
use App\Http\Controllers\Controller;
use App\Models\Appointments;
use App\Models\User;
use App\Models\Doctor;
use App\Models\UserDetails;
use Illuminate\Support\Facades\Auth;

class HomeController extends Controller
{
    //
    public function index(){

        if(Auth::user()->usertype == 'admin'){

        
          
         
         
           $data = [
            'patients' => User::with('user_details')->where('type', 'user')->get(),
            'doctors' => User::with('doctor')->where('type', 'doctor')->where('usertype', 'doctor')->get(),
            'user_details'=>UserDetails::all(),
            'appointments'=>Appointments::with('doctor', 'users')->get()   
                   ];

         return View('admin.admin_home',compact('data'));
        }
   
         else
          {
            return View('dashboard');
          }
     }}
 