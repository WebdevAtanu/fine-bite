"use client"

import React from 'react'
import SideSheet from '@/components/re-usable/side-sheet';
import { ColumnDef } from "@tanstack/react-table"
import { DataTable } from '@/components/re-usable/data-table'
import { MoreHorizontal } from "lucide-react"
import { CityDataType } from '../city.interface';

import { Button } from "@/components/ui/button"
import {
    DropdownMenu,
    DropdownMenuContent,
    DropdownMenuItem,
    DropdownMenuLabel,
    DropdownMenuSeparator,
    DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu"
import CityInsert from './city-insert';

function CityView() {

    const columns: ColumnDef<CityDataType>[] = [
        {
            accessorKey: "id",
            header: "ID",
        },
        {
            accessorKey: "name",
            header: "Name",
        },
        {
            accessorKey: "country",
            header: "Country",
        },
        {
            header: "Actions",
            id: "actions",
            cell: ({ row }) => {
                const city = row.original // Access the original data for the row

                return (
                    <DropdownMenu>
                        <DropdownMenuTrigger asChild>
                            <Button variant="ghost" className="h-8 w-8 p-0">
                                <span className="sr-only">Open menu</span>
                                <MoreHorizontal className="h-4 w-4" />
                            </Button>
                        </DropdownMenuTrigger>
                        <DropdownMenuContent align="end">
                            <DropdownMenuLabel>Actions</DropdownMenuLabel>
                            <DropdownMenuSeparator />
                            <DropdownMenuItem>
                                <p>Edit {city.name}</p>
                            </DropdownMenuItem>
                            <DropdownMenuItem>
                                <p>Delete {city.name}</p>
                            </DropdownMenuItem>
                        </DropdownMenuContent>
                    </DropdownMenu>
                )
            },
        },
    ]

    const dummyCity_data: CityDataType[] = [
        {
            id: "1",
            name: "London",
            country: "UK",
        },
        {
            id: "2",
            name: "New York",
            country: "USA",
        },
    ]

    return (
        <div>
            <div className="flex justify-end mb-4">
                <SideSheet
                    title="Add City"
                    description="Add a new city to the database"
                    trigger={<Button>Add City</Button>}
                >
                    {CityInsert()}
                </SideSheet>
            </div>

            <DataTable columns={columns} data={dummyCity_data} />
        </div>
    )
}

export default CityView