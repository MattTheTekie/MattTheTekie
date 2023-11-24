import type { ReactElement, ReactNode } from 'react'
import { tv } from 'tailwind-variants'

const treeItem = tv({
  slots: {
    item: 'text-stone-300'
  }
})

const { item } = treeItem({})

interface TreeListProps {
  children?: ReactNode
}

export default function TreeItem ({
  children
}: TreeListProps): ReactElement {
  return (
    <li className={item()}>
      {children}
    </li>
  )
}