import { Calendar, Edit, Gift, Library, Home } from "lucide-react"
import { NavLink, useLocation } from "react-router-dom"
import { MilitaryLogo } from "./ui/ghost-logo"

import {
  Sidebar,
  SidebarContent,
  SidebarGroup,
  SidebarGroupContent,
  SidebarGroupLabel,
  SidebarMenu,
  SidebarMenuButton,
  SidebarMenuItem,
  SidebarHeader,
} from "@/components/ui/sidebar"

const items = [
  { title: "Home", url: "/", icon: Home },
  { title: "Create Post", url: "/create-post", icon: Edit },
  { title: "Lead Magnet AI", url: "/lead-magnet", icon: Gift },
  { title: "Post Library", url: "/post-library", icon: Library },
  { title: "Content Calendar", url: "/content-calendar", icon: Calendar },
]

export function AppSidebar() {
  const location = useLocation()
  const currentPath = location.pathname

  const isActive = (path: string) => currentPath === path

  return (
    <Sidebar className="w-64 border-r border-border">
      <SidebarHeader className="p-6 border-b border-border">
        <div className="flex items-center space-x-2">
          <MilitaryLogo size="md" />
          <div>
            <h1 className="font-mono font-bold text-lg text-transparent bg-clip-text bg-gradient-to-r from-[#1B998B] to-[#1B998B] tracking-wider">
              Ghost Protocol
            </h1>
            <p className="text-sm text-muted-foreground tracking-widest uppercase font-medium">
              LEAD MAGNET AI
            </p>
          </div>
        </div>
      </SidebarHeader>

      <SidebarContent>
        <SidebarGroup>
          <SidebarGroupLabel className="text-[#1B998B] uppercase tracking-wider text-sm font-bold">
            NAVIGATION MATRIX
          </SidebarGroupLabel>
          <SidebarGroupContent>
            <SidebarMenu>
              {items.map((item) => (
                <SidebarMenuItem key={item.title}>
                  <SidebarMenuButton asChild>
                    <NavLink 
                      to={item.url}
                      className={({ isActive }) =>
                        `flex items-center space-x-3 px-4 py-3 rounded-lg transition-all duration-300 w-full futuristic-border glow-hover text-base font-medium tracking-wide ${
                          isActive
                            ? "bg-gradient-to-r from-[#1B998B]/20 to-[#1B998B]/20 text-[#1B998B] font-medium border border-[#1B998B]/30"
                            : "text-sidebar-foreground hover:bg-gradient-to-r hover:from-[#1B998B]/10 hover:to-[#1B998B]/10 hover:text-[#1B998B]/80"
                        }`
                      }
                    >
                      {({ isActive }) => (
                        <>
                          <item.icon className={`h-5 w-5 ${isActive ? 'text-[#1B998B] scale-110 drop-shadow-glow' : ''}`} />
                          <span className="tracking-wide font-medium">{item.title}</span>
                          {isActive && item.title === 'Create Post' && (
                            <span className="w-2 h-2 bg-[#1B998B] rounded-full ml-auto animate-pulse"></span>
                          )}
                        </>
                      )}
                    </NavLink>
                  </SidebarMenuButton>
                </SidebarMenuItem>
              ))}
            </SidebarMenu>
          </SidebarGroupContent>
        </SidebarGroup>
      </SidebarContent>
    </Sidebar>
  )
}