module ApplicationHelper
  def will_remote_paginate(collection, params = {})
    will_paginate(collection, params.merge(renderer: PaginationHelpers::RemoteLinkPaginationHelper::LinkRenderer))
  end
end
