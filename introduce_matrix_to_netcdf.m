%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all; close all;
set(0,'Units','pixels');
scnsize = get(0,'ScreenSize');
pos1 = [10, 10, 1910, 1070];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% model = 'SS';
% filename = 'SS_model.cdl';
% file = 'vP_for_oceanographers.txt';
% % '		',model,':standard_name = "Speed of sound in m/s" ;\n'...
% % '		',model,':long_name = "Speed of sound in m/s from FWI" ;\n'...
% % '		',model,':units = "m/s" ;\n'...

model = 'temp';
filename = 'T_model.cdl';
file = 'T_oceanographers.txt';
% '		',model,':standard_name = "Temperature in C" ;\n'...
% '		',model,':long_name = "Temperature in C from FWI" ;\n'...
% '		',model,':units = "C_degrees" ;\n'...

% model = 'sal';
% filename = 'S_model.cdl';
% file = 'S_oceanographers.txt';
% % '		',model,':standard_name = "Salinity in PSU" ;\n'...
% % '		',model,':long_name = "Salinity in PSU from FWI" ;\n'...
% % '		',model,':units = "PSU" ;\n'...

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
header_netcdf = ...
['// Info NETCDF: http://cfconventions.org/cf-conventions/v1.6.0/cf-conventions.html\n'...
'//               http://badc.nerc.ac.uk/help/formats/netcdf/nc_utilities.html\n'...
'\n'...
'netcdf speedofsound {\n'...
'dimensions:\n'...
'	d_time  = 1 ; // UNLIMITED;\n'...
'	d_depth = 281 ;\n'...
'	d_shot  = 11061 ;\n'...
'variables:\n'...
'	double time(d_time) ;\n'...
'		time:standard_name = "time" ;\n'...
'		time:units = "seconds since 2007-05-02 15:00:00" ;\n'...
'		time:long_name = "time" ;\n'...
'	float depth(d_depth) ;\n'...
'		depth:standard_name = "depth" ;\n'...
'		depth:units = "meters" ;\n'...
'		depth:long_name = "depth" ;\n'...
'	float shot(d_shot) ;\n'...
'		shot:standard_name = "shot position" ;\n'...
'		shot:units = "meters" ;\n'...
'		shot:long_name = "shot position in my model" ;\n'...
'	float latitude(d_shot) ;\n'...
'		latitude:standard_name = "latitude" ;\n'...
'		latitude:units = "degrees_north" ;\n'...
'		latitude:long_name = "latitude" ;\n'...
'	float longitude(d_shot) ;\n'...
'  	longitude:standard_name = "longitude" ;\n'...
'		longitude:units = "degrees_east" ;\n'...
'		longitude:long_name = "longitude" ;\n'...
'	float ',model,'(d_shot, d_depth) ;\n'...
'		',model,':standard_name = "Temperature in C" ;\n'...
'		',model,':long_name = "Temperature in C from FWI" ;\n'...
'		',model,':units = "C_degrees" ;\n'...
'\n'...
'// global attributes:\n'...
'   :Conventions = "CF-1.0" ;\n'...
'		:institute = "ICM B-CSI" ;\n'...
'		:source = "Modele inverted from GO in the South of Cádiz" ;\n'...
'		:history = "SO-LR01\\n",\n'...
'			   			 "2009-05-01.\\n" ;\n'...
'		:title = "Oceanographic FWI " ;\n'...
'		:comment = "Nothing" ;\n'...
'		:references = "D. Dagnino dagnino@icm.csic.es" ;\n'...
'\n'...
'data:\n'...
];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
mat = load(file);
nx = length(mat(1,:))
nz = length(mat(:,1))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
x_lat_lon  = load('x_model_lat_lon.txt');

x_model = x_lat_lon(:,1);
lat_model = x_lat_lon(:,2);
lon_model = x_lat_lon(:,3);
nx_model = length(x_lat_lon)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% For oceanographers
fid = fopen( filename, 'w' );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
fprintf( fid, header_netcdf );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% time
fprintf( fid, 'time = 0.; \n' );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% depth
fprintf( fid, 'depth = ' );

cont = 0;
for iz=1:nz
  
  fprintf( fid, '%12.5e', 200+5*(iz-1) );
  
  if ( iz ~= nz )
    fprintf( fid, ', ' );
  end
  
  cont = cont + 1;
  if ( cont == 50 )
    fprintf( fid, '\n' );
    cont = 0;
  end
  
end

fprintf( fid, ';\n' );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% shot number
fprintf( fid, 'shot = ' );

cont = 0;
for ix=1:nx
  
  fprintf( fid, '%12.5e', x_model(ix) );
  
  if ( ix ~= nx )
    fprintf( fid, ', ' );
  end
  
  cont = cont + 1;
  if ( cont == 50 )
    fprintf( fid, '\n' );
    cont = 0;
  end
  
end

fprintf( fid, ';\n' );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lat
fprintf( fid, 'latitude = ' );

cont = 0;
for ix=1:nx
  
  fprintf( fid, '%12.5e', lat_model(ix) );
  
  if ( ix ~= nx )
    fprintf( fid, ', ' );
  end
  
  cont = cont + 1;
  if ( cont == 50 )
    fprintf( fid, '\n' );
    cont = 0;
  end
  
end

fprintf( fid, ';\n' );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lon
fprintf( fid, 'longitude = ' );

cont = 0;
for ix=1:nx
  
  fprintf( fid, '%12.5e', lon_model(ix) );
  
  if ( ix ~= nx )
    fprintf( fid, ', ' );
  end
  
  cont = cont + 1;
  if ( cont == 50 )
    fprintf( fid, '\n' );
    cont = 0;
  end
  
end

fprintf( fid, ';\n' );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% data
fprintf( fid, [model,' = '] );

cont = 0;
for ix=1:nx
  
  for iz=1:nz
    fprintf( fid, '%11.5e', mat(iz,ix) );
    
    if ( ix ~= nx || iz ~= nz )
      fprintf( fid, ',' );
    end
    
%     cont = cont + 1;
%     if ( cont == 50 )
%       fprintf( fid, '\n' );
%       cont = 0;
%     end
    
  end
  
end

fprintf( fid, '; \n }' );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
fclose(fid);






