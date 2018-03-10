


clc
clear all
warning('off','all')


imgs =[];

img0X = struct('name','','data',[],'type','img');

%% 1. rész
%Kép beolvasása
%lena.png fájl betöltése az 'I' változóba
fileName = 'lena';
format = '.jpeg';
I=imread(strcat(fileName,format));

img00 = struct('name',fileName,'data',I,'type','img');
img00h = struct('name',fileName,'data',I,'type','his');

%% 2. rész
%A csatornák kiemelése, szürkeárnyalatos kép elkészítése
%red_I, gree_I, és blue_I, gray_I képváltozók feltöltése
I_red=I(:,:,1);
I_green=I(:,:,2);
I_blue=I(:,:,3);


img01 = struct('name','red','data',I_red,'type','img');
img02 = struct('name','green','data',I_green,'type','img');
img03 = struct('name','blue','data',I_blue,'type','img'); 
img03h = struct('name','blue','data',I_blue,'type','his'); 


%% 3. rész
%A szürkeárnyalatos kép és hisztogramjának megjelenítése
%figure 1 létrehozása
I_gray=rgb2gray(I);

img04 = struct('name','rgb2gray','data',I_gray,'type','img');
img05 = struct('name','rgb2gray','data',I_gray,'type','his');


%% 4. rész
%Intenzitásértékek növelése/csökkentése és ezek hatása a hisztogramra
%tetsz?leges szürkeárnyalatosított képen (red, green, blue vagy gray)
%figure 2 tartalmazza a kiválasztott szürkeárnyalatosított képet,
%hisztogramját, a módosított képet és annak hisztogramját is!

intensity = 20;
I_gray_plus = imadd(I, intensity);
I_gray_minus = imadd(I, -intensity);

img06 = struct('name','intensity (+)','data',I_gray_plus,'type','img');
img07 = struct('name','intensity (+)','data',I_gray_plus,'type','his');
img08 = struct('name','intensity (-)','data',I_gray_minus,'type','img');
img09 = struct('name','intensity (-)','data',I_gray_minus,'type','his');


%% 5.rész
%Hisztogramkiegyenlítés és kontrasztnyújtás
%Kék csatorna használatával, módosított képek és eredeti
%összehasonlítása 'figure 3'-ban

I_eq=histeq(I_blue);
I_stretchBlue = imadjust(I_blue, stretchlim(I_blue));

img10 = struct('name','eq','data',I_eq,'type','img');
img11 = struct('name','eq','data',I_eq,'type','his');
img12 = struct('name','stretch blue','data',I_stretchBlue,'type','img');
img13 = struct('name','stretch blue','data',I_stretchBlue,'type','his');


%% 6. rész
%Einstein hozzáadása a nasaképhez
% 


I_nasa=imread('nasa_image.jpg');
I_einstein=imread('einstein.bmp');

I_nasa_small = imresize(I_nasa, size(I_einstein));
I_nasa_small_gray = rgb2gray(I_nasa_small);

ratio = 0.7; 
I_combo = imadd(I_nasa_small_gray.*ratio,I_einstein.*(1-ratio));


img14 = struct('name','Nasa (resized, gray)','data',I_nasa_small_gray,'type','img');
img14h = struct('name','Nasa','data',I_nasa_small_gray,'type','his');
img15 = struct('name','Einstein (original)','data',I_einstein,'type','img');
img15h = struct('name','Einstein','data',I_einstein,'type','his');

img20 = struct('name',strcat('Nasa (',num2str(ratio),') + Einstein (',num2str(1-ratio),')'),'data',I_combo,'type','img');
img20h = struct('name','Nasa + Einstein','data',I_combo,'type','his');



%% PLOTS
plotter('6. rész', [img14,img14h;img15,img15h; img20,img20h]);
plotter('5. rész',  mergeForPlotter([img00,img00h],[img10,img11;img03,img03h;img12,img13], img0X));
plotter('4. rész',  mergeForPlotter([img00,img00h],[img06,img07;img08,img09], img0X));
plotter('1-3. rész', mergeForPlotter([img00,img00h],[img01,img02,img03; img04,img05,img0X], img0X));

