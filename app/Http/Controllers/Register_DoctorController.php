<?php
namespace App\Actions\Fortify;
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\Doctor;
use App\Models\User;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Hash; 

class Register_DoctorController extends Controller
{
    //
  public function create(){

    return View('doctor_register_form');
  }

  public function store(Request $request)
    {
        $data = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users'],
            'password' => ['required', 'string', 'min:8', 'confirmed'], // Add validation for password confirmation
        ]);

        // Create user
        $user = User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'type' => 'doctor',
            'password' => Hash::make($data['password']),
        ]);

        // Create doctor information
        $doctorInfo = Doctor::create([
            'doc_id' => $user->id,
            'status' => 'active',
        ]);

        return redirect('/home')->with('success', 'Doctor created successfully!'); // Redirect with success message
    }
}
