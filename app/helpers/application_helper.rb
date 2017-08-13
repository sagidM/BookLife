module ApplicationHelper
  def will_remote_paginate(collection, params = {})
    will_paginate(collection, params.merge(renderer: PaginationHelpers::RemoteLinkPaginationHelper::LinkRenderer))
  end

  def redirect_or_default_path
    params[:redirect_to] || root_path
  end
end
