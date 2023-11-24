import type { ReactElement, ReactNode } from 'react'
import type { ITreeView, NoteData, NoteNode } from './utils/types'
import { useEffect, useState } from 'react'
import { Tree } from './'

import { generateTree } from './utils/generateTree'
import { toggleNode } from './utils/toggleNode'
import { sortTree } from './utils/sortTree'

interface TreeRootProps {
  notes: Array<{ slug: string, data: NoteData }>
  pathname: string
}

interface RecursiveRenderProps {
  tree: ITreeView<NoteNode>
  pathname: string
}

const RecursiveRender = ({
  tree,
  pathname
}: RecursiveRenderProps): ReactNode => {
  const retrieveOpenedNodes = pathname.split('/').filter(Boolean)
  const [openNodes, setOpenNodes] = useState<Set<string>>(new Set())
  const sortedTree = sortTree(tree)

  return sortedTree.map(([key, value]) => {
    const isMap = value instanceof Map
    const slug = isMap ? undefined : value.slug

    useEffect(() => {
      if (retrieveOpenedNodes.includes(key)) {
        setOpenNodes(prev => new Set(prev.add(key)))
      }
    }, [pathname])

    return (
      <Tree.Item key={key}>
        <Tree.Node
          type={isMap ? 'folder' : 'file'}
          pathname={pathname}
          slug={slug}
        >
          <Tree.Button onClick={() => { setOpenNodes(toggleNode(openNodes, key)) }}>
            {isMap && (
              <Tree.Icon open={openNodes.has(key)} />
            )}
            <span className='text-left'>
              {isMap ? key : value.title}
            </span>
          </Tree.Button>
        </Tree.Node>
        {isMap && openNodes.has(key) && (
          <Tree.List>
            <RecursiveRender
              tree={value}
              pathname={pathname}
            />
          </Tree.List>
        )}
      </Tree.Item>
    )
  })
}

export default function TreeRoot ({
  notes,
  pathname
}: TreeRootProps): ReactElement {
  const [tree, setTree] = useState(generateTree(notes))

  useEffect(() => {
    const updatedTree = generateTree(notes)
    if (updatedTree !== tree) {
      setTree(updatedTree)
    }
  }, [notes])

  return (
    <Tree.List type="main">
      <RecursiveRender
        tree={tree}
        pathname={pathname}
      />
    </Tree.List>
  )
}