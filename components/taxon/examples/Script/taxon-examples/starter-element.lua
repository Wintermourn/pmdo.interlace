--[[
    starter-element
    This example creates a tag for monsters that:
    - Are only elements Fire/None
    - Have no previous promotion
    - Have at least one possible promotion
]]

-- To make sure this script is just one file, we create the json file we need
local header = RogueEssence.PathMod.GetModFromNamespace 'taxon-examples'
local IO = luanet.namespace 'System.IO'
local tag_path = IO.Path.Combine(
    RogueEssence.PathMod.APP_PATH,
    header.Path,
    RogueEssence.Data.DataManager.DATA_PATH, 'Tags', 'origin', 'Monster', 'taxon-examples:starter'
)

-- ensures that our required directory exists
if not IO.Directory.Exists(tag_path) then IO.Directory.CreateDirectory(tag_path) end

-- Below is what makes our tag's info
local element = 'fire'
local element_path = IO.Path.Combine(tag_path, element .. '.json')
if not IO.File.Exists(element_path) then
    IO.File.WriteAllText(
        element_path,
---@language json
([[
{
    "scans": [
        {
            "Form.Element1": "%s",
            "Form.Element2": "none",
            "Object.Promotions": {
                "type": "not_empty"
            },
            "Object.PromoteFrom": ""
        }
    ]
}
]]):format(element)
        )
end

local taxon = require 'taxon-examples.taxon'
print(tostring(taxon.get_tag('Monster', 'taxon-examples:starter/'.. element)))
-- print all monster IDs in the tag
for entry in taxon.get_tag('Monster', 'taxon-examples:starter/'.. element):iterate_keys() do
    print('\t'.. entry)
end