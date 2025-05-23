terraform { 
  cloud { 
    
    organization = "tanvir-rifat" 

    workspaces { 
      name = "fem-eci-workspace" 
    } 
  } 
}