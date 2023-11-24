import { useState, useEffect, useRef, type KeyboardEventHandler, type ReactNode } from 'react'
import { PiMagnifyingGlass } from 'react-icons/pi'

interface Entry {
  title: string
  slug: string
}

interface SearchboxProps {
  entries: Entry[]
}

export default function Searchbox (props: SearchboxProps): ReactNode {
  const [searchQuery, setSearchQuery] = useState('')
  const [selectedIndex, setSelectedIndex] = useState(-1)
  const [isDropdownOpen, setIsDropdownOpen] = useState(false)
  const containerRef = useRef<HTMLDivElement>(null)
  const dropdownRef = useRef<HTMLDivElement>(null)

  const toggleDropdown = (): void => {
    setIsDropdownOpen(!isDropdownOpen)
  }

  const handleKeyDown: KeyboardEventHandler<HTMLInputElement> = (event): void => {
    event.preventDefault()

    if (event.key === 'ArrowDown') {
      setSelectedIndex((prevIndex) => Math.min(prevIndex + 1, props.entries.length - 1))
    } else if (event.key === 'ArrowUp') {
      setSelectedIndex((prevIndex) => Math.max(prevIndex - 1, -1))
    } else if (event.key === 'Enter') {
      const entry = props.entries[selectedIndex]

      if (entry != null) {
        window.location.href = `/brain/${entry.slug}`
      }
    }
  }

  useEffect(() => {
    const handleClickOutside = (event: MouseEvent): void => {
      if ((containerRef.current != null) && !containerRef.current.contains(event.target as Node)) {
        setIsDropdownOpen(false)
      }
    }

    document.addEventListener('mousedown', handleClickOutside)

    return () => {
      document.removeEventListener('mousedown', handleClickOutside)
    }
  }, [])

  useEffect(() => {
    if (isDropdownOpen && (dropdownRef.current != null)) {
      const selectedItem = dropdownRef.current.querySelector('#selected') as HTMLElement

      if (selectedItem != null) {
        const dropdownHeight = dropdownRef.current.clientHeight
        const scrollThreshold = selectedItem.offsetTop + selectedItem.clientHeight - dropdownHeight

        if (selectedItem.offsetTop >= scrollThreshold) {
          dropdownRef.current.scrollTop =
            selectedItem.offsetTop - dropdownHeight + selectedItem.clientHeight
        }
      }
    }
  }, [isDropdownOpen, selectedIndex])

  const filteredEntries = props.entries.filter((entry) =>
    entry.title.toLowerCase().includes(searchQuery.toLowerCase())
  )

  return (
    <div className="relative" ref={containerRef}>
      <div className="flex items-center w-full rounded-sm p-1 px-2 text-stone-300 text-sm bg-neutral-800 border border-stone-700">
        <PiMagnifyingGlass size={18} />
        <input
          type="text"
          placeholder="Search page..."
          className="w-full bg-transparent p-1 ml-2 focus:outline-none"
          onKeyUp={handleKeyDown}
          onFocus={toggleDropdown}
          onChange={(event) => {
            setSearchQuery(event.target.value)
            setSelectedIndex(-1)
          }}
        />
      </div>

      {isDropdownOpen && (
        <div className="absolute p-0 top-full flex flex-col max-h-[35rem] overflow-y-scroll mt-2 left-0 w-full bg-neutral-800 rounded-sm border border-stone-700" ref={dropdownRef}>
          {filteredEntries.length > 0
            ? filteredEntries.map((entry, index) => (
                <a
                  key={index}
                  className={`${index === selectedIndex ? 'bg-neutral-700 selected' : 'hover:bg-neutral-600'} px-4 py-2 cursor-pointer hover:no-underline`}
                  href={`/brain/${entry.slug}`}
                  id={index === selectedIndex ? 'selected' : undefined}
                  aria-label={entry.title}
                  title={entry.title}
                >
                  {entry.title}
                </a>
            ))
            : props.entries.map((entry, index) => (
                <a
                  key={index}
                  className={`${index === selectedIndex ? 'bg-neutral-700 selected' : 'hover:bg-neutral-600'} px-4 py-2 cursor-pointer hover:no-underline`}
                  href={`/brain/${entry.slug}`}
                  id={index === selectedIndex ? 'selected' : undefined}
                  aria-label={entry.title}
                  title={entry.title}
                >
                  {entry.title}
                </a>
            ))}
        </div>
      )}
    </div>
  )
}