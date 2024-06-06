
<x-app-layout>
	<x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Admin Dashboard') }}
        </h2>
    </x-slot>


    

      <!DOCTYPE html>
      <html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
         
     
         <head>
             <meta charset="utf-8">
             <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
             <title>Admin Dashboard</title>
             
             <!-- Favicon -->
             <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.png">
             
             <!-- Bootstrap CSS -->
             <link rel="stylesheet" href="assets/css/bootstrap.min.css">
             
             <!-- Fontawesome CSS -->
             <link rel="stylesheet" href="assets/css/font-awesome.min.css">
             
             <!-- Feathericon CSS -->
             <link rel="stylesheet" href="assets/css/feathericon.min.css">
             
             <link rel="stylesheet" href="assets/plugins/morris/morris.css">
             
             <!-- Main CSS -->
             <link rel="stylesheet" href="assets/css/style.css">
             
         
         </head>
         <body>
         
             <!-- Main Wrapper -->
             <div class="main-wrapper">
             
                 <!-- Header -->
                 <div class="header">
             
                     
                     <a href="javascript:void(0);" id="toggle_btn">
                         <i class="fe fe-text-align-left"></i>
                     </a>
                     
                     <!-- Mobile Menu Toggle -->
                     <a class="mobile_btn" id="mobile_btn">
                         <i class="fa fa-bars"></i>
                     </a>
                     <!-- /Mobile Menu Toggle -->
                     
                     <!-- Header Right Menu -->
                     <ul class="nav user-menu">
     
                         <!-- Notifications -->
                         <li class="nav-item dropdown noti-dropdown">
                             <a href="#" class="dropdown-toggle nav-link" data-toggle="dropdown">
                                 <i class="fe fe-bell"></i> <span class="badge badge-pill">3</span>
                             </a>
                             <div class="dropdown-menu notifications">
                                 
                                 <div class="noti-content">
                                     <ul class="notification-list">
                                         <li class="notification-message">
                                             <a href="#">
                                                 <div class="media">
                                                     <span class="avatar avatar-sm">
                                                         <img class="avatar-img rounded-circle" alt="User Image" src="assets/img/doctors/doctor-thumb-01.jpg">
                                                     </span>
                                                     <div class="media-body">
                                                         <p class="noti-details"><span class="noti-title">Dr. Ruby Perrin</span> Schedule <span class="noti-title">her appointment</span></p>
                                                         <p class="noti-time"><span class="notification-time">4 mins ago</span></p>
                                                     </div>
                                                 </div>
                                             </a>
                                         </li>
                                         <li class="notification-message">
                                             <a href="#">
                                                 <div class="media">
                                                     <span class="avatar avatar-sm">
                                                         <img class="avatar-img rounded-circle" alt="User Image" src="assets/img/patients/patient1.jpg">
                                                     </span>
                                                     <div class="media-body">
                                                         <p class="noti-details"><span class="noti-title">Charlene Reed</span> has booked her appointment to <span class="noti-title">Dr. Ruby Perrin</span></p>
                                                         <p class="noti-time"><span class="notification-time">6 mins ago</span></p>
                                                     </div>
                                                 </div>
                                             </a>
                                         </li>
                                         <li class="notification-message">
                                             <a href="#">
                                                 <div class="media">
                                                     <span class="avatar avatar-sm">
                                                         <img class="avatar-img rounded-circle" alt="User Image" src="assets/img/patients/patient2.jpg">
                                                     </span>
                                                     <div class="media-body">
                                                     <p class="noti-details"><span class="noti-title">Travis Trimble</span> sent a amount of $210 for his <span class="noti-title">appointment</span></p>
                                                     <p class="noti-time"><span class="notification-time">8 mins ago</span></p>
                                                     </div>
                                                 </div>
                                             </a>
                                         </li>
                                         <li class="notification-message">
                                             <a href="#">
                                                 <div class="media">
                                                     <span class="avatar avatar-sm">
                                                         <img class="avatar-img rounded-circle" alt="User Image" src="assets/img/patients/patient3.jpg">
                                                     </span>
                                                     <div class="media-body">
                                                         <p class="noti-details"><span class="noti-title">Carl Kelly</span> send a message <span class="noti-title"> to his doctor</span></p>
                                                         <p class="noti-time"><span class="notification-time">12 mins ago</span></p>
                                                     </div>
                                                 </div>
                                             </a>
                                         </li>
                                     </ul>
                                 </div>
                                 <div class="topnav-dropdown-footer">
                                     <a href="#">View all Notifications</a>
                                 </div>
                             </div>
                         </li>
                         <!-- /Notifications -->
                         
                         
                     </ul>
                     <!-- /Header Right Menu -->
                     
                 </div>
             
                 
             
                 
                 <!-- Page Wrapper -->
                 <div class="page-wrapper">
                 
                     <div class="content container-fluid">
                         
                         <div class="row">
                             <div class="col-xl-3 col-sm-6 col-12">
                                 <div class="card">
                                     <div class="card-body">
                                         <div class="dash-widget-header">
                                             <span class="dash-widget-icon text-primary border-primary">
                                                 <i class="fe fe-users"></i>
                                             </span>
                                             <div class="dash-count">
                                                 <h3>{{count( $data['doctors'])}}</h3>
                                             </div>
                                         </div>
                                         <div class="dash-widget-info">
                                             <h6 class="text-muted">Doctors</h6>
                                             <div class="progress progress-sm">
                                                 <div class="progress-bar bg-primary w-50"></div>
                                             </div>
                                         </div>
                                     </div>
                                 </div>
                             </div>
                             <div class="col-xl-3 col-sm-6 col-12">
                                 <div class="card">
                                     <div class="card-body">
                                         <div class="dash-widget-header">
                                             <span class="dash-widget-icon text-success">
                                                 <i class="fe fe-credit-card"></i>
                                             </span>
                                             <div class="dash-count">
                                                 <h3>{{count( $data['user_details'])}}</h3>
                                             </div>
                                         </div>
                                         <div class="dash-widget-info">
                                             
                                             <h6 class="text-muted">Patients</h6>
                                             <div class="progress progress-sm">
                                                 <div class="progress-bar bg-success w-50"></div>
                                             </div>
                                         </div>
                                     </div>
                                 </div>
                             </div>
                             <div class="col-xl-3 col-sm-6 col-12">
                                 <div class="card">
                                     <div class="card-body">
                                         <div class="dash-widget-header">
                                             <span class="dash-widget-icon text-danger border-danger">
                                                 <i class="fe fe-money"></i>
                                             </span>
                                             <div class="dash-count">
                                                 <h3>{{count( $data['appointments']) }}</h3>
                                             </div>
                                         </div>
                                         <div class="dash-widget-info">
                                             
                                             <h6 class="text-muted">Appointment</h6>
                                             <div class="progress progress-sm">
                                                 <div class="progress-bar bg-danger w-50"></div>
                                             </div>
                                         </div>
                                     </div>
                                 </div>
                             </div>
                             <div class="col-xl-3 col-sm-6 col-12">
                                 <div class="card">
                                     <div class="card-body">
                                         <div class="dash-widget-header">
                                             <span class="dash-widget-icon text-warning border-warning">
                                                 <i class="fe fe-folder"></i>
                                             </span>
                                             <div class="dash-count">
                                                 {{-- <h3>$62523</h3> --}}
                                             </div>
                                         </div>
                                         
                                     </div>
                                 </div>
                             </div>
                         </div>
                         <div class="row text-center">
                             <div class="col-md-12 col-lg-6">
                             
                                 <!-- Add Doctor -->
                                 <div class="card card-chart">
                                     <div class="card-header">
                                         
                                         <h1> 

                                          
                                            <a href="{{ route('register') }}" class="btn btn-success">Add Doctor</a>
                                         

                                             {{-- @if (Route::has('register'))
                                             <div class="btn btn-outline-primary"><a href="{{ route('register') }}">Add Doctor</button></a></div>
                                             @endif --}}
                                             
     
                                         </h1>
     
                                     </div>
                                     <div class="card-body">
                                         <div id="morrisArea"></div>
                                     </div>
                                 </div>
                                 <!-- /Add Doctor -->
                                 
                             </div>
                             <div class="col-md-12 col-lg-6">
                             
                                 <!-- Invoice Chart -->
                                 <div class="card card-chart">
                                     <div class="card-header">
                                         <button type="button" class="btn btn-danger">Remove Doctor</button>
                                     </div>
                                     <div class="card-body">
                                         <div id="morrisLine"></div>
                                     </div>
                                 </div>
                                 <!-- /Invoice Chart -->
                                 
                             </div>	
                         </div>
                         <div class="row">
                             <div class="col-md-6 d-flex">
                             
                                 <!-- Recent Orders -->
                                 <div class="card card-table flex-fill">
                                     <div class="card-header">
                                         <h4 class="card-title">Doctors List</h4>
                                     </div>
                                     <div class="card-body">
                                         <div class="table-responsive">
                                             <table class="table table-hover table-center mb-0">
                                                 <thead>
                                                     <tr>
                                                         <th>Doctor Name</th>
                                                         <th>Speciality</th>
                                                         <th>Status</th>
                                                     </tr>
                                                 </thead>
                                                 <tbody>
                                                     @foreach ($data['doctors'] as $doctor)
                                                         
                                                     <tr>
                                                         <td>
                                                             <h2 class="table-avatar">
                                                                 <a href="profile.html" class="avatar avatar-sm mr-2"><img src="{{ Storage::url($doctor->profile_photo_path) ?? asset('img/doctors/doctor-thumb-02.jpg') }}" 
                                                                    alt="Doctor Image"></a>
                                                                 <a href="profile.html">Dr. {{$doctor->name }}</a>
                                                             </h2>
                                                         </td>
                                                         <td>{{$doctor->doctor->category}}</td>
                                                         <td>
                                                            {{$doctor->doctor->status}}
                                                         </td>
                                                     </tr>
                                                     @endforeach
                                                 
                                                 </tbody>
                                             </table>
                                         </div>
                                     </div>
                                 </div>
                                 <!-- /Recent Orders -->
                                 
                             </div>
                             <div class="col-md-6 d-flex">
                             
                                 <!-- Feed Activity -->
                                 <div class="card  card-table flex-fill">
                                     <div class="card-header">
                                         <h4 class="card-title">Patients List</h4>
                                     </div>
                                     <div class="card-body">
                                         <div class="table-responsive">
                                             <table class="table table-hover table-center mb-0">
                                                 <thead>
                                                     <tr>													
                                                         <th>Patient Name</th>
                                                         <th>Phone</th>
                                                         <th>Age</th>	
                                                         <th>Email</th>													
                                                     </tr>
                                                 </thead>
                                                 <tbody>
                                                     @foreach ($data['patients']  as $patient)
                                                         
                                                    
                                                     
                                                     <tr>
                                                         <td>
                                                             <h2 class="table-avatar">
                                                                 <a href="profile.html" class="avatar avatar-sm mr-2"></a>
                                                                 <a href="profile.html">{{$patient->name}}</a>
                                                             </h2>
                                                         </td>
                                                         <td>{{$patient->user_details->bio_data ?? 'N/A'}}</td>
                                                         <td>{{$patient->user_details->status ?? 'N/A'}}</td>
                                                         <td>{{$patient->email ?? 'N/A'}}</td>
                                                        
                                                     </tr>
                                                     
                                                     @endforeach 
                                                 </tbody>
                                             </table>
                                         </div>
                                     </div>
                                 </div>
                                 <!-- /Feed Activity -->
                                 
                             </div>
                         </div>
                         <div class="row">
                             <div class="col-md-12">
                             
                                 <!-- Recent Orders -->
                                 <div class="card card-table">
                                     <div class="card-header">
                                         <h4 class="card-title">Appointment List</h4>
                                     </div>
                                     <div class="card-body">
                                         <div class="table-responsive">
                                             <table class="table table-hover table-center mb-0">
                                                 <thead>
                                                     <tr>
                                                        <th>Patient Name</th>
                                                        <th>Apointment Time</th>
                                                        <th>Selected Doctor</th>
                                                        <th>Speciality</th>
                                                        <th>Status</th>
                                                        
                                                     </tr>
                                                 </thead>
                                                 <tbody>
                                                    @foreach ($data['appointments']  as $appointment)
                                                     <tr>
                                                         
                                                        
                                                         <td>
                                                             <h2 class="table-avatar">
                                                                 <a href="profile.html" class="avatar avatar-sm mr-2"><img class="avatar-img rounded-circle" src="assets/img/patients/patient3.jpg" alt="User Image"></a>
                                                                 <a href="profile.html">{{ $appointment->users->name }}</a>
                                                             </h2>
                                                         </td>
                                                         <td>11 Nov 2019 <span class="text-primary d-block">{{$appointment->day}}</span></td>
                                                         <td>
                                                            <h2 class="table-avatar">
                                                                <a href="profile.html" class="avatar avatar-sm mr-2"><img class="avatar-img rounded-circle" src="assets/img/doctors/doctor-thumb-03.jpg" alt="User Image"></a>
                                                                <a href="profile.html">Dr. {{$appointment->doctor->name}}</a>
                                                            </h2>
                                                        </td>
                                                        <td>{{$appointment->doctor->category}}</td>
                                                         <td>
                                                             <div class="status-toggle">
                                                                 <input type="checkbox" id="status_3" class="check" checked>
                                                                 <label for="status_3" class="checktoggle">checkbox</label>
                                                             </div>
                                                         </td>
                                                         
                                                     </tr>
                                                     @endforeach 
                                                 </tbody>
                                             </table>
                                         </div>
                                     </div>
                                 </div>
                                 <!-- /Recent Orders -->
                                 
                             </div>
                         </div>
                         
                     </div>			
                 </div>
                 <!-- /Page Wrapper -->
             
             </div>
             <!-- /Main Wrapper -->
             
             <!-- jQuery -->
             <script src="assets/js/jquery-3.2.1.min.js"></script>
             
             <!-- Bootstrap Core JS -->
             <script src="assets/js/popper.min.js"></script>
             <script src="assets/js/bootstrap.min.js"></script>
             
             <!-- Slimscroll JS -->
             <script src="assets/plugins/slimscroll/jquery.slimscroll.min.js"></script>
             
             <script src="assets/plugins/raphael/raphael.min.js"></script>    
             <script src="assets/plugins/morris/morris.min.js"></script>  
             <script src="assets/js/chart.morris.js"></script>
             
             <!-- Custom JS -->
             <script  src="assets/js/script.js"></script>
             
         </body>
     
     
     </html>
         
         
  
</x-app-layout>

















