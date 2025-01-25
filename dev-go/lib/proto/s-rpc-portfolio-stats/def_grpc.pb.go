// Code generated by protoc-gen-go-grpc. DO NOT EDIT.
// versions:
// - protoc-gen-go-grpc v1.3.0
// - protoc             v4.25.4
// source: s-rpc-portfolio-stats/def.proto

package s_rpc_portfolio_stats

import (
	context "context"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
	emptypb "google.golang.org/protobuf/types/known/emptypb"
)

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
// Requires gRPC-Go v1.32.0 or later.
const _ = grpc.SupportPackageIsVersion7

const (
	PortfolioStats_Report_FullMethodName = "/s_rpc_portfolio_stats.PortfolioStats/Report"
)

// PortfolioStatsClient is the client API for PortfolioStats service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
type PortfolioStatsClient interface {
	Report(ctx context.Context, in *Visit, opts ...grpc.CallOption) (*emptypb.Empty, error)
}

type portfolioStatsClient struct {
	cc grpc.ClientConnInterface
}

func NewPortfolioStatsClient(cc grpc.ClientConnInterface) PortfolioStatsClient {
	return &portfolioStatsClient{cc}
}

func (c *portfolioStatsClient) Report(ctx context.Context, in *Visit, opts ...grpc.CallOption) (*emptypb.Empty, error) {
	out := new(emptypb.Empty)
	err := c.cc.Invoke(ctx, PortfolioStats_Report_FullMethodName, in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// PortfolioStatsServer is the server API for PortfolioStats service.
// All implementations must embed UnimplementedPortfolioStatsServer
// for forward compatibility
type PortfolioStatsServer interface {
	Report(context.Context, *Visit) (*emptypb.Empty, error)
	mustEmbedUnimplementedPortfolioStatsServer()
}

// UnimplementedPortfolioStatsServer must be embedded to have forward compatible implementations.
type UnimplementedPortfolioStatsServer struct {
}

func (UnimplementedPortfolioStatsServer) Report(context.Context, *Visit) (*emptypb.Empty, error) {
	return nil, status.Errorf(codes.Unimplemented, "method Report not implemented")
}
func (UnimplementedPortfolioStatsServer) mustEmbedUnimplementedPortfolioStatsServer() {}

// UnsafePortfolioStatsServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to PortfolioStatsServer will
// result in compilation errors.
type UnsafePortfolioStatsServer interface {
	mustEmbedUnimplementedPortfolioStatsServer()
}

func RegisterPortfolioStatsServer(s grpc.ServiceRegistrar, srv PortfolioStatsServer) {
	s.RegisterService(&PortfolioStats_ServiceDesc, srv)
}

func _PortfolioStats_Report_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(Visit)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(PortfolioStatsServer).Report(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: PortfolioStats_Report_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(PortfolioStatsServer).Report(ctx, req.(*Visit))
	}
	return interceptor(ctx, in, info, handler)
}

// PortfolioStats_ServiceDesc is the grpc.ServiceDesc for PortfolioStats service.
// It's only intended for direct use with grpc.RegisterService,
// and not to be introspected or modified (even as a copy)
var PortfolioStats_ServiceDesc = grpc.ServiceDesc{
	ServiceName: "s_rpc_portfolio_stats.PortfolioStats",
	HandlerType: (*PortfolioStatsServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "Report",
			Handler:    _PortfolioStats_Report_Handler,
		},
	},
	Streams:  []grpc.StreamDesc{},
	Metadata: "s-rpc-portfolio-stats/def.proto",
}
