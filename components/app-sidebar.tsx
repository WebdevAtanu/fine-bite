"use client";
import { useState, useEffect } from "react";
import {
    Sidebar,
    SidebarContent,
    SidebarGroup,
    SidebarGroupContent,
    SidebarGroupLabel,
    SidebarMenu,
    SidebarMenuItem,
    SidebarMenuButton,
} from "@/components/ui/sidebar";
import { Spinner } from "./ui/spinner";
import { Home, Users} from "lucide-react";
import * as api from "@/lib/apiService";
import { MenuInterface } from "@/features/menu/menu.interface";
import Link from "next/link";

function MenuItems({ menu }: { menu: MenuInterface }) {
    const iconMap = {
        home: Home,
        user: Users,
    };

    const Icon = iconMap[menu.menuIcon as keyof typeof iconMap];

    return (
        <SidebarMenuItem>
            <SidebarMenuButton asChild>
                <Link href={menu.menuName}>
                    {Icon && <Icon className="mr-2 h-4 w-4" />}
                    {menu.menuName}
                </Link>
            </SidebarMenuButton>
        </SidebarMenuItem>
    );
}

export function AppSidebar() {
    const [menus, setMenus] = useState<MenuInterface[]>([]); // state to store menus
    const [loading, setLoading] = useState(true); // state to track loading
    const [error, setError] = useState<string | null>(null); // state to track errors

    useEffect(() => {
        let isMounted = true; // flag to check if component is mounted

        const fetchMenus = async () => {
            try {
                const result = await api.get<{ data: MenuInterface[] }>("/menu"); // fetch menus
                if (isMounted) setMenus(result.data); // update state
            } catch (err: any) {
                if (isMounted) setError(err?.message || "Failed to fetch");
            } finally {
                if (isMounted) setLoading(false); // update loading state 
            }
        };

        fetchMenus(); // call the function

        return () => {
            isMounted = false; // unmount the component
        };
    }, []);

    return (
        <Sidebar>
            <SidebarContent>
                <SidebarGroup>
                    <SidebarGroupLabel>My App</SidebarGroupLabel>
                    <SidebarGroupContent>
                        <SidebarMenu>
                            {
                                loading ?
                                    <div className="flex w-full justify-center items-center">
                                        <Spinner className="size-6" />
                                    </div>
                                    :
                                    menus.map((menu) => (
                                        <MenuItems key={menu.menuId} menu={menu} />
                                    ))
                            }
                        </SidebarMenu>
                    </SidebarGroupContent>
                </SidebarGroup>
            </SidebarContent>
        </Sidebar>
    );
}