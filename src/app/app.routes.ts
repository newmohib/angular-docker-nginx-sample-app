// src/app/app.routes.ts
import { Routes } from '@angular/router';
import { HomeComponent } from './home/home.component';
import { AboutComponent } from './about/about.component';

export const routes: Routes = [ // Export the routes array as "routes"
  { path: '', component: HomeComponent },
  { path: 'about', component: AboutComponent }
];
